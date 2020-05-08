#!/bin/bash

#notify-send "right..."
xdotool set_desktop $(($(xdotool get_desktop) - 1))
