#!/bin/bash
###
 # @FilePath    : ctof.sh
 # @Description :
 # @Author      : Songshuai
 # @Date        : 2024-12-18 15:24:28
 # @Copyright (c) 2024 by Songshuai(Songshuai223@gmail.com), All Rights Reserved.
 #
 # @History record
 #  version     date      auther     changes
 #  V0.1.0  currenttime  Songshuai    Create
###

# Variable
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
cputemp=$(expr $temp / 1000)
base=0

# Main
Fahrenheit=$(expr $cputemp  + $base)
echo $Fahrenheit

exit
