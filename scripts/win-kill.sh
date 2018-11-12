#!/bin/bash

if [[ "$(xdotool getactivewindow getwindowname)" != "python3" ]]; then
	ID=$(xdotool getactivewindow)
	i3-msg "[id=$ID] kill"
fi
