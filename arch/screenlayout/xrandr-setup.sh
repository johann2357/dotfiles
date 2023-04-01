#!/bin/sh

# export DISPLAY=:0
N_MONITORS=`xrandr --listmonitors | grep "Monitors: " | awk {'print $2'}`

case "$N_MONITORS" in
2)
  IS_OFFICE_1=`xrandr --listmonitors | grep -c "HDMI-1 1920/...x1080/"`
  IS_OFFICE_2=`xrandr --listmonitors | grep -c "HDMI-1 3440/...x1440/"`
  if [ "$IS_OFFICE_1" = "1" ]
  then
    xrandr --output eDP-1 --mode 1920x1080 --pos 1920x540 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off
    feh --bg-scale /home/johann/Pictures/ocean-fishing.jpg /home/johann/Pictures/ocean-fishing.jpg
  elif [ "$IS_OFFICE_2" = "1" ]
  then
    xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 3440x1440 --pos 1920x0 --rotate normal --output DP-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off
    feh --bg-fill /home/johann/Pictures/mountains-1.jpg
  else
    echo "No config found for such monitor."
    feh --bg-scale /home/johann/Pictures/ocean-fishing.jpg
  fi
  ;;
*)
  echo "Using default xrandr config."
  feh --bg-scale /home/johann/Pictures/ocean-fishing.jpg
  ;;
esac
