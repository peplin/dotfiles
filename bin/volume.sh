#!/usr/bin/env bash

CURVOL=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5/10 }' | cut -d . -f 1 | sed 's/%//g')
case $CURVOL in
  0)     bar='[----------]' ;;
  1)   bar='[#---------]' ;;
  2)   bar='[##--------]' ;;
  3)   bar='[###-------]' ;;
  4)   bar='[####------]' ;;
  5)  bar='[#####-----]' ;;
  6)  bar='[######----]' ;;
  7)  bar='[#######---]' ;;
  8)  bar='[########--]' ;;
  9)  bar='[#########-]' ;;
  10) bar='[##########]' ;;
  MM) bar='[---Muted---]' ;;
  *)  bar='[----------]' ;;
esac

echo $bar
