#!/usr/bin/env sh
# Render Spotify MPRIS metadata as Waybar JSON, including a readable tooltip.
# Supports native players and Spotify MediaSession instances in browsers.

set -eu

PLAY=$(printf '\xf3\xb0\x90\x8a')
PAUSE=$(printf '\xf3\xb0\x8f\xa4')

emit() {
  _player="$1"
  _status="$2"
  _artist="$(playerctl -p "$_player" metadata --format '{{ artist }}' 2>/dev/null || true)"
  _title="$(playerctl -p "$_player" metadata --format '{{ title }}' 2>/dev/null || true)"
  [ -n "$_title" ] || return 0
  _icon="$PAUSE"
  [ "$_status" = Playing ] && _icon="$PLAY"
  _track="$_title"
  [ -z "$_artist" ] || _track="$_artist — $_title"
  _text="$(printf "<span font_family='Symbols Nerd Font Mono'>%s</span> %s" "$_icon" "$_track")"
  _tooltip="$(printf '%s — %s\n%s\n%s' "$_player" "$_status" "$_artist" "$_title")"
  jq -cn --arg text "$_text" --arg tooltip "$_tooltip" '{text:$text,tooltip:$tooltip}'
  exit 0
}

for name in spotify audacious rhythmbox strawberry lollypop; do
  STATUS="$(playerctl -p "$name" status 2>/dev/null || true)"
  case "$STATUS" in
  Playing | Paused) emit "$name" "$STATUS" ;;
  esac
done

for player in $(playerctl -l 2>/dev/null || true); do
  case "$(printf '%s' "$player" | tr '[:upper:]' '[:lower:]')" in
  spotify | audacious | rhythmbox | strawberry | lollypop) continue ;;
  chrome* | chromium* | firefox* | brave* | edge* | vivaldi* | opera*)
    STATUS="$(playerctl -p "$player" status 2>/dev/null || true)"
    case "$STATUS" in
    Playing | Paused)
      META="$(playerctl -p "$player" metadata 2>/dev/null || true)"
      case "$META" in
      *[Ss]potify*) emit "$player" "$STATUS" ;;
      esac
      ;;
    esac
    ;;
  esac
done

printf '%s\n' '{"text":"","tooltip":""}'
