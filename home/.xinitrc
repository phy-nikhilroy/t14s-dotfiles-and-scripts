#!/bin/sh

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

export GTK_USE_PORTAL=1
systemctl --user import-environment DISPLAY XAUTHORITY

picom --backend glx --vsync --daemon &

dunst &

exec bspwm
