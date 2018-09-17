#!/usr/bin/env bash
set -e

#windows is finicky!
#if you get an "nodemcu_uploader.exceptions.DeviceNotFoundException: Device not found or wrong port"
#Ive noticed that flashing with esptool makes the error go away, work(tm)
if grep -q Microsoft /proc/version; then
  echo "Ubuntu on Windows"
  nodemcu-uploader.exe --port COM5 file remove init.lua 
  sleep 1
  nodemcu-uploader.exe --port COM5 upload init.lua application.lua location.lua 
  echo "uploaded lua-files"
  sleep 1
  nodemcu-uploader.exe --port COM5 node restart
  echo "restarted node"
  nodemcu-uploader.exe --port COM5 terminal
else
  echo "native Linux"
  nodemcu-uploader --port /dev/ttyUSB0 file remove init.lua 
  sleep 1
  nodemcu-uploader --port /dev/ttyUSB0 upload init.lua application.lua location.lua 
  echo "uploaded lua-files"
  sleep 1
  nodemcu-uploader --port /dev/ttyUSB0 node restart
  echo "restarted node"
  nodemcu-uploader --port /dev/ttyUSB0 terminal
fi
