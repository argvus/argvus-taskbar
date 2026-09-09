#!/usr/bin/env sh
# Detect music player content — native app or via browser MediaSession.
# Outputs Pango-markup icon + "artist — title" if a player is active.
# Supported: Spotify, Audacious, Rhythmbox, Strawberry, Lollypop,
#            and Spotify via browser (Firefox, Chrome, Brave, etc.).

# Symbols Nerd Font: md-play=U+F040A, md-pause=U+F03E4
PLAY=$(printf '\xf3\xb0\x90\x8a')
PAUSE=$(printf '\xf3\xb0\x8f\xa4')

icon() {
    printf "<span font_family='Symbols Nerd Font Mono'>%s</span>" "$1"
}

emit() {
    STATUS="$1"; TRACK="$2"
    if [ "$STATUS" = "Playing" ]; then IC=$(icon "$PLAY"); else IC=$(icon "$PAUSE"); fi
    echo "$IC $TRACK"
    exit 0
}

# ── Native players (by playerctl name) ──
for name in spotify audacious rhythmbox strawberry lollypop; do
    STATUS=$(playerctl -p "$name" status 2>/dev/null)
    if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
        TRACK=$(playerctl -p "$name" metadata --format "{{ artist }} — {{ title }}" 2>/dev/null)
        emit "$STATUS" "$TRACK"
    fi
done

# ── Spotify via browser (check metadata for spotify URL) ──
for player in $(playerctl -l 2>/dev/null); do
    case "$(echo "$player" | tr '[:upper:]' '[:lower:]')" in
        spotify|audacious|rhythmbox|strawberry|lollypop) continue ;;
        chrome*|chromium*|firefox*|brave*|edge*|vivaldi*|opera*)
            STATUS=$(playerctl -p "$player" status 2>/dev/null)
            if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
                META=$(playerctl -p "$player" metadata 2>/dev/null)
                case "$META" in
                    *[Ss]potify*)
                        TRACK=$(playerctl -p "$player" metadata --format "{{ artist }} — {{ title }}" 2>/dev/null)
                        emit "$STATUS" "$TRACK"
                        ;;
                esac
            fi
            ;;
    esac
done

exit 0
