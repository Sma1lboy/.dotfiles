#!/bin/bash

update() {
  if [ "$SELECTED" = "true" ]; then
    sketchybar --set $NAME \
      background.color=0xff9D7CD8 \
      icon.color=0xffffffff
  else
    sketchybar --set $NAME \
      background.color=0x66494d64 \
      icon.color=0xffcad3f5
  fi
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac