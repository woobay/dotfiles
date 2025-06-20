#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in {1..8}; do
  sketchybar --add item space.$sid left \
    --set space.$sid \
    display="1" \
    drawing=on \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.height=25 \
    icon="$sid" \
    icon.padding_left=10 \
    icon.padding_right=10 \
    label.drawing=off \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid" \
    --subscribe space.$sid aerospace_workspace_change
done

for sid in {9..10}; do
  sketchybar --add item space.$sid left \
    --set space.$sid \
    display="2" \
    drawing=on \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.height=25 \
    icon="$sid" \
    icon.padding_left=10 \
    icon.padding_right=10 \
    label.drawing=off \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid" \
    --subscribe space.$sid aerospace_workspace_change
done
