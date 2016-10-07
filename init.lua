-- Config
dofile("config.lua")
dofile("rgbled.lua")

led = rgbled.init(pin_led_r, pin_led_g, pin_led_b)
led.set(waiting_wifi_color)

-- Connect to AP
wifi.setmode(wifi.STATION)
-- wifi.sta.setip(ip_config)
wifi.sta.config(ap_ssid, ap_pass)

-- When node connects, run sensor code
tmr.alarm(0, 1000, 1, function()
   if wifi.sta.status()~=5 then
      print("[mictor.io][WiFi] Connecting to AP...")
   else
     led.set(waiting_mqtt_color)
     print("[mictor.io][WiFi] Connected")
     dofile("mictor_io_node.lua")
     tmr.stop(0)
   end
end)
