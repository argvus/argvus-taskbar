#!/bin/sh
# Waybar runs the checks asynchronously, without modifying the system database.
set -u
translate() {
  argvus i18n get control-center "$1" 2>/dev/null || printf '%s' "$2"
}
mkdir -p /tmp/argvus || exit 1
work_dir=$(mktemp -d /tmp/argvus/update-status.XXXXXX) || exit 1
trap 'rm -rf "$work_dir"' EXIT HUP INT TERM
official_label=$(translate control_center.taskbar_update_official 'Official repositories')
error_label=$(translate control_center.taskbar_update_error 'Update check failed')
no_helper_label=$(translate control_center.taskbar_update_no_helper 'AUR helper paru or yay is not installed')
status=0
timeout 120 checkupdates >"$work_dir/official" 2>"$work_dir/official-error" || status=$?
error=false
if [ "$status" -ne 0 ] && [ "$status" -ne 2 ]; then
  error=true
  : >"$work_dir/official"
fi
if [ "$status" -eq 2 ] && [ -s "$work_dir/official-error" ]; then error=true; fi
official_count=$(awk 'NF { count++ } END { print count+0 }' "$work_dir/official")
tooltip="$official_label: $official_count"
[ "$error" = false ] || tooltip="$official_label: $error_label"
: >"$work_dir/aur"
check_aur=$(argvus config get /taskbar/icons/update_aur_enabled --effective --raw 2>/dev/null || printf false)
if [ "$check_aur" = true ]; then
  helper=''
  if command -v paru >/dev/null 2>&1; then helper=paru
  elif command -v yay >/dev/null 2>&1; then helper=yay
  fi
  if [ -z "$helper" ]; then
    error=true
    tooltip="$tooltip
AUR: $no_helper_label"
  else
    status=0
    timeout 120 "$helper" -Qua >"$work_dir/aur" 2>"$work_dir/aur-error" || status=$?
    if [ "$status" -ne 0 ] && ! { [ "$status" -eq 1 ] && [ ! -s "$work_dir/aur" ] && [ ! -s "$work_dir/aur-error" ]; }; then
      error=true
      : >"$work_dir/aur"
      tooltip="$tooltip
AUR: $error_label"
    else
      aur_count=$(awk 'NF { count++ } END { print count+0 }' "$work_dir/aur")
      tooltip="$tooltip
AUR: $aur_count"
    fi
  fi
fi
count=$(awk 'NF && !seen[$1]++ { count++ } END { print count+0 }' "$work_dir/official" "$work_dir/aur")
if [ "$error" = true ]; then count="$count?"; fi
jq -cn --arg text "$count" --arg tooltip "$tooltip" --arg class "$( [ "$error" = true ] && printf error || printf current )" '{text:$text,tooltip:$tooltip,class:$class}'
