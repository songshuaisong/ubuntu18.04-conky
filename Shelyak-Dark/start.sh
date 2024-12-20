#!/bin/bash
###
 # @FilePath    : start.sh
 # @Description : 启动脚本
 # @Author      : Songshuai
 # @Date        : 2024-12-18 10:27:30
 # @Copyright (c) 2024 by Songshuai(Songshuai223@gmail.com), All Rights Reserved.
 #
 # @History record
 #  version     date      auther     changes
 #  V0.1.0  2024-12-18   Songshuai    Create
###

# This command will close all active conky
killall conky
sleep 2s

# Only the config listed below will be avtivated
# if you want to combine with another theme, write the command here
conky -c $HOME/.config/conky/Shelyak-Dark/Shelyak-Dark.conf  &> /dev/null &

exit
