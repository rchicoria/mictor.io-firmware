-- AP
ap_ssid = "mictor.io-WiFi"
ap_pass = "#bexig@envergonHada"

-- IP
-- ip_config = {ip="192.168.1.1", netmask="255.255.255.0", gateway="192.168.1.254"}

-- Sensor frame_id
frame_id = "urinol2"

-- MQTT
mqtt_host = "104.236.192.113"
mqtt_port = 1883
mqtt_start_topic = "mictor-io.start"
mqtt_end_topic = "mictor-io.end"
mqtt_node_topic = "mictor-io.node."..frame_id

-- RGB LED pinout
pin_led_r = 1 -- GPIO5
pin_led_g = 2 -- GPIO4
pin_led_b = 3 -- GPIO0

waiting_wifi_color = {0, 0, 512}
waiting_mqtt_color = {512, 0, 512}
waiting_piss_color = {0, 512, 0}
waiting_stop_color = {512, 0, 0}
pissing_color = {512, 220, 0}

-- Sonar pinout
pin_sonar_trigger = 4 -- GPIO2
pin_sonar_echo = 5 -- GPI14

-- Algorithm
distance_threshold = 0.4
