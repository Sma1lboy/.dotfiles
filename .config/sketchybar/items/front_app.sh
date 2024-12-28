#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

front_app=(
  script="$PLUGIN_DIR/front_app.sh"
  icon.drawing=on
  icon.font="$FONT:Bold:16.0"
  icon.color=0xffcad3f5
  icon.padding_left=10
  icon.padding_right=5
  label.color=0xffcad3f5
  label.font="$FONT:Medium:13.0"
  padding_left=5
  padding_right=5
  background.color=0x66494d64
  background.corner_radius=8
  background.height=26
  background.drawing=on
  associated_display=active
  updates=on
)

sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched window_focus