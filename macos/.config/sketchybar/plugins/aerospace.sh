#!/usr/bin/env bash
# aerospace.sh

WORKSPACE_ID="$1"
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$CURRENT_WORKSPACE" = "$WORKSPACE_ID" ]; then
  sketchybar --set space.$WORKSPACE_ID background.border_width=2 background.color=0x88ffffff
else
  sketchybar --set space.$WORKSPACE_ID background.border_width=0 background.color=0x44ffffff
fi
