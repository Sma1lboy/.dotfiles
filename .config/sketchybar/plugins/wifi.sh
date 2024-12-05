 #!/usr/bin/env sh


WIFI_SPEED="$(sudo wdutil info | grep "Tx Rate" | sed -E 's/.*Tx Rate *: *(.* Mbps)/\1/')"

if [ "$WIFI_SPEED" = "0.0 Mbps" ]; then
  sketchybar --set $NAME label="No Internet" icon=󰖪
else
  sketchybar --set $NAME label="$WIFI_SPEED" icon=
fi 
