#!/usr/bin/env sh

# shellcheck disable=SC1091
. /usr/share/argvus/lib/i18n.sh

_format="${1:-weekday_day_month}"
_weekday="$(date '+%u')"
_month_num="$(date '+%m')"
_day_num="$(date '+%d')"
_year="$(date '+%Y')"

argvus_tr taskbar "date.format.${_format}" \
  "weekday=$(argvus_tr taskbar "date.weekday.${_weekday}")" \
  "day=${_day_num#0}" \
  "day_padded=${_day_num}" \
  "month=$(argvus_tr taskbar "date.month.${_month_num#0}")" \
  "month_num=${_month_num}" \
  "year=${_year}"
