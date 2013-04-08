#!/usr/bin/env bash

name_test=$(amixer | grep Master)
if [[ $? == 0 ]]; then
    mixer_name="Master"
else
    mixer_name="PCM"
fi

vol=$(amixer get $mixer_name | awk -F'[]%[]' '/%/ {if ($7 == "off") \
    { print "MM" } else { print $2/10 }}' | head -n 1 | cut -d . -f 1)

case $vol in
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
