#!/usr/bin/env sh

# shellcheck disable=SC1091
. /usr/share/argvus/lib/i18n.sh

_weekday="$(date '+%u')"
_month="$(date '+%-m')"
_day="$(date '+%d')"

argvus_tr taskbar date.format \
  "weekday=$(argvus_tr taskbar "date.weekday.${_weekday}")" \
  "day=${_day#0}" \
  "month=$(argvus_tr taskbar "date.month.${_month}")"
