#!/usr/bin/env bash

autorandr -c

xrdb -merge $HOME/.dotfiles/x/Xresources.base
if [ $HOSTNAME == "X1C-PF3VJF1V" ]; then
    autorandr | grep current | grep mobile && powerprofilesctl set balanced
    autorandr | grep current | grep mobile && xrdb -merge $HOME/.dotfiles/x/Xresources.laptop
    autorandr | grep current | grep mobile && xsettingsd --config $HOME/.dotfiles/x/xsettingsd-96 &
    autorandr | grep current | grep dion-desk && xrdb -merge $HOME/.dotfiles/x/Xresources.laptop
    autorandr | grep current | grep dion-desk && xsettingsd --config $HOME/.dotfiles/x/xsettingsd-96 &
    autorandr | grep current | grep dion-desk && powerprofilesctl set performance
    autorandr | grep current | grep docked && xsettingsd --config $HOME/.dotfiles/x/xsettingsd-120 &
    autorandr | grep current | grep docked && xrdb -merge $HOME/.dotfiles/x/Xresources.work
    autorandr | grep current | grep docked && powerprofilesctl set performance
elif [ $HOSTNAME -eq "tangent" ]; then
    xrdb -merge $HOME/.dotfiles/x/Xresources.laptop
    xsettingsd --config $HOME/.dotfiles/x/xsettingsd-120 &
fi

#killall -HUP xsettingsd

xmonad --restart

xmodmap $HOME/.dotfiles/x/modcapslock
