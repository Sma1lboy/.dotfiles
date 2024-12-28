#!/bin/bash

# Numbers for spaces
NUMBER_ICONS=("1" "2" "3" "4" "5" "6" "7")
# Icons for each space type
SPACE_ICONS=("󰨞" "󰖟" "󰭹" "󰎈" "󰋩" "󱎯" "󰎆")

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  space=(
    associated_space=$sid
    icon="${NUMBER_ICONS[i]} ${SPACE_ICONS[i]}"
    icon.padding_left=8
    icon.padding_right=8
    padding_left=5
    padding_right=5
    icon.highlight_color=0xffC678DD
    icon.font="$FONT:Bold:14.0"
    label.drawing=off
    background.color=0x66494d64
    background.corner_radius=4
    background.height=24
    background.drawing=on
    script="$PLUGIN_DIR/space.sh"
  )
  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

# Bracket configuration
spaces=(
  background.color=0x00000000
  background.border_width=0
  background.drawing=off
)

# Separator with chevron
separator=(
  icon=􀆊
  icon.font="$FONT:Bold:14.0"
  padding_left=8
  padding_right=8
  label.drawing=off
  associated_display=active
  click_script='yabai -m space --create && sketchybar --trigger space_change'
  icon.color=0xffC678DD
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
           --add item separator left          \
           --set separator "${separator[@]}"