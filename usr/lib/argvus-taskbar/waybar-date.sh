#!/usr/bin/env sh

capitalize() {
  _value="$1"
  _first="${_value%"${_value#?}"}"
  _rest="${_value#?}"
  _upper="$(printf '%s' "$_first" | tr '[:lower:]' '[:upper:]')"
  printf '%s%s' "$_upper" "$_rest"
}

_date="$(date '+%a|%d|%B')"
_weekday="${_date%%|*}"
_remaining="${_date#*|}"
_day="${_remaining%%|*}"
_month="${_remaining#*|}"

printf '%s, %s %s\n' "$(capitalize "$_weekday")" "$_day" "$(capitalize "$_month")"
