#!/usr/bin/env bash

autorandr -c

xrdb -merge $HOME/.dotfiles/x/Xresources.base
if [ $HOSTNAME == "X1C-PF3VJF1V" ]; then
    autorandr | grep current | grep mobile && xrdb -merge $HOME/.dotfiles/x/Xresources.laptop
    autorandr | grep current | grep mobile && xsettingsd --config $HOME/.dotfiles/x/xsettingsd-96 &
    autorandr | grep current | grep docked && xsettingsd --config $HOME/.dotfiles/x/xsettingsd-120 &
elif [ $HOSTNAME -eq "tangent" ]; then
    xrdb -merge $HOME/.dotfiles/x/Xresources.laptop
    xsettingsd --config $HOME/.dotfiles/x/xsettingsd-120 &
fi

#killall -HUP xsettingsd

xmonad --restart

xmodmap $HOME/.dotfiles/x/modcapslock
