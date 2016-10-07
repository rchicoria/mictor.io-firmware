# mictor.io-firmware

## Introduction

An AirBnB for urinals at public toilets

## Description

mictor.io is a cloud based platform for managing public urinals usage. Based on the popular paper "The Urinal Problem" [1], mictor.io relies on a set of wireless modules places at each urinal to sense when a urinal is being used. Furthermore it uses an intuitive color system to tell the user which urinal to use by means of a color LED. Finally a web-based app provides analytics with several metrics including:

  * Time spent at urinal (average, max, min)
  * Average distance from urinal
  * Most/least used urinal
  * Number of algorithm violations
  * Time of the day with most/least urinal usages

## Hardware

  * ESP8266 [2] running NodeMCU [3]
  * HCSR04 Ultrasonic Raging Sensor
  * RGB LED

### Loading the Firmware

Start by flashing the NodeMCU into the ESP8266 using esptool:

'''
python esptool.py --port /dev/tty.USB0 erase_flash
python esptool.py --port /dev/tty.USB0 write_flash 0x00000 nodemcu_float_0.9.6-dev_20150704.bin
'''

The firmware can be sent over to the ESP using a tool such as ESPlorer [4]

### Protocol



## More

Learn more at: https://github.com/rchicoria/mictor.io

Live Preview: http://104.236.192.113:3000

[1]: http://people.scs.carleton.ca/~kranakis/Papers/urinal.pdf
[2]: https://www.olimex.com/Products/IoT/MOD-WIFI-ESP8266-DEV/
[3]: http://www.nodemcu.com
[4]: http://esp8266.ru/esplorer/
