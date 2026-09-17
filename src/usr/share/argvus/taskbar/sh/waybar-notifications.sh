#!/usr/bin/env bash
set -eu

# shellcheck disable=SC1091
. /usr/share/argvus/lib/i18n.sh

if ! status="$(argvus-notifications status 2>/dev/null)"; then
  printf '{"text":"󰂛","tooltip":"%s","class":"unavailable"}\n' \
    "$(argvus_tr taskbar notifications.unavailable)"
  exit 0
fi

dnd="${status#dnd=}"
if [ "$dnd" = true ]; then
  icon='󰂛'
  tooltip="$(argvus_tr taskbar notifications.dnd_enabled)"
  class='dnd'
else
  icon='󰂚'
  tooltip="$(argvus_tr taskbar notifications.enabled)"
  class='enabled'
fi

jq -cn --arg text "$icon" --arg tooltip "$tooltip" --arg class "$class" \
  '{text:$text, tooltip:$tooltip, class:$class}'
