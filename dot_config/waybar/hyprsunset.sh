#!/bin/bash

# start waybar if not started
if ! pgrep -x "hyprsunset" > /dev/null; then
	hyprsunset -t 5000 &
else
    killall hyprsunset
fi
