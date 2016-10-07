dofile("hcsr04.lua")

-- Setup
pissing = false
waiting_mode = 'go_away'
distance = 0
avg_distance = 0
start_time = tmr.now()

sonar = hcsr04.init(pin_sonar_trigger, pin_sonar_echo)
tmr.alarm(1, 1000, 1, function()
  distance = sonar.measure_avg()
  print("[mictor.io][HC-SR04] Distance "..distance)
end)

-- Connect to mqtt broker
function connect()
  print("[mictor.io][MQTT] Connecting to MQTT...")
  m:connect(mqtt_host, mqtt_port, 0, 0, function(client)
    print("[mictor.io][MQTT] Connected")
    mqtt_connected = true
    if waiting_mode == 'piss_here' then
      led.set(waiting_piss_color)
    else
      led.set(waiting_stop_color)
    end
    m:subscribe(mqtt_node_topic, 0, function(client) print("[mictor.io][MQTT] Subscribed to "..mqtt_node_topic) end)
  end)
end

-- On mqtt offline
mqtt_connected = false
m = mqtt.Client(wifi.sta.getmac(), 120)
m:on("offline", function(client)
  led.set(waiting_mqtt_color)
  print("[mictor.io][MQTT] Offline, reconnecting...")
  mqtt_connected = false
  connect()
end)

-- On message from mqtt
m:on("message", function(client, topic, data)
  if data ~= nil then
    print("[mictor.io][MQTT] Got message "..data)
    json = cjson.decode(data)
    for key, value in pairs(json) do
      if key == 'status' then
        waiting_mode = value
        if waiting_mode == 'piss_here' then
          led.set(waiting_piss_color)
        else
          led.set(waiting_stop_color)
        end
      end
    end
  end
end)

-- Send a message over mqtt
function sendMessage(topic, msg)
  print("[mictor.io][MQTT] Sending "..msg)
  m:publish(topic, msg, 0, 0, function(client)
    print("[mictor.io][MQTT] Message sent")
  end)
end

-- Main loop
connect()
tmr.alarm(2, 1000, 1, function()
  if mqtt_connected then
    -- If someone steps into the urinol
    if distance < distance_threshold and distance > 0 and pissing == false then
      pissing = true
      led.set(pissing_color)
      avg_distance = distance
      start_time = tmr.now()
      json = string.format('{"frame_id": "%s", "data": {"waiting_for_piss": ', frame_id)
      if waiting_mode == 'piss_here' then
        json = json..'true}}'
      else
        json = json..'false}}'
      end
      sendMessage(mqtt_start_topic, json)
    -- If that person is still pissing
    elseif distance < distance_threshold and distance > 0 and pissing == true then
      avg_distance = (avg_distance+distance)/2.0
    -- If that person walks away from the urinol
    elseif distance > distance_threshold and pissing == true then
      time = (tmr.now() - start_time)/1000000.0
      json = string.format('{"frame_id": "%s", "data": {"distance": %f, "time_elapsed": %f}}', frame_id, avg_distance, time)
      sendMessage(mqtt_end_topic, json)
      pissing = false
      if waiting_mode == 'piss_here' then
        led.set(waiting_piss_color)
      else
        led.set(waiting_stop_color)
      end
    end
  end
end)