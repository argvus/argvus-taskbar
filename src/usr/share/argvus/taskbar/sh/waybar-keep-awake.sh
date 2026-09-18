#!/usr/bin/env bash
set -eu

# shellcheck disable=SC1091
. /usr/share/argvus/lib/i18n.sh

status="$(/usr/share/argvus/power/sh/keep-awake.sh status 2>/dev/null || printf disabled)"
if [ "$status" = enabled ]; then
  icon='󰅶'
  tooltip="$(argvus_tr taskbar keep_awake.enabled)"
  class='enabled'
else
  icon='󰾪'
  tooltip="$(argvus_tr taskbar keep_awake.disabled)"
  class='disabled'
fi

jq -cn --arg text "$icon" --arg tooltip "$tooltip" --arg class "$class" \
  '{text:$text, tooltip:$tooltip, class:$class}'
