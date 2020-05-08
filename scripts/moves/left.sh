#!/bin/bash

#notify-send "left..."
xdotool set_desktop $(($(xdotool get_desktop) + 1))
