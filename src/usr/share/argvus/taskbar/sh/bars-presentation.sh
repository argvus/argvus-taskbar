#!/bin/sh
set -eu

config_home=${ARGVUS_CONFIG_HOME:-${XDG_CONFIG_HOME:-"$HOME/.config"}}
data_home=${ARGVUS_DATA_HOME:-"$config_home/argvus/data"}
theme="$data_home/generated/theme/current"
runtime="${XDG_RUNTIME_DIR:?}/argvus/bars"
mkdir -p "$runtime"

settings=$(argvus config bars-config)
taskbar_palette=$(cat "$theme/taskbar/theme.css" 2>/dev/null || :)
telemetry_palette=$(cat "$theme/widget-telemetry/theme.css" 2>/dev/null || :)

snapshot=$(jq -en \
  --argjson settings "$settings" \
  --arg taskbar_palette "$taskbar_palette" --arg telemetry_palette "$telemetry_palette" \
  --arg launcher "$theme/taskbar/menu.svg" '
  def palette:
    [split("\n")[] | capture("^@define-color +(?<key>[^ ]+) +(?<value>[^;]+);")]
    | map({(.key): .value}) | add // {};
  def qt_rgba:
    if . == null then null
    else ([scan("[0-9]+(?:\\.[0-9]+)?") | tonumber]) as $rgba |
      if ($rgba | length) == 4 then
        [$rgba[0] / 255, $rgba[1] / 255, $rgba[2] / 255, $rgba[3]]
      else null end
    end;
  ($settings.taskbar // {}) as $taskbar |
  ($settings.layout // {}) as $layout |
  ($settings.effects // {}) as $effects |
  ($settings.fonts.targets // {}) as $fonts |
  ($settings.appearance // {}) as $appearance |
  def transparency($surface; $default):
    if $effects["transparency_" + $surface + "_enabled"] == false then 1
    else 1 - (($effects["transparency_" + $surface + "_value"] // $default) / 100) end;
  ($layout.taskbar // {}) as $bar |
  ($layout.window // {}) as $win |
  ($taskbar_palette | palette) as $bar_colors |
  ($telemetry_palette | palette) as $telemetry_colors |
  {
    taskbar: {
      position: ($bar.position // "top"),
      marginTop: ($bar.margin_top // 0),
      marginRight: ($bar.margin_right // 0),
      marginBottom: ($bar.margin_bottom // 2),
      marginLeft: ($bar.margin_left // 0),
      height: ($taskbar.shape.height // 24),
      borderWidth: ($taskbar.shape.border_width // (if ($appearance.theme // "") == "slate-dark" then 0 else 1 end)),
      radius: (if $layout.variant == "spaced" then 4 else 0 end),
      icons: ($taskbar.icons // {}),
      utilityExpanded: ($taskbar.icons.utilities.expanded // false),
      workspacePresentation: ($taskbar.workspaces.presentation // "labels"),
      dateFormat: ($taskbar.date.format // "weekday_day_month"),
      timeFormat: ($taskbar.time.format // "24h"),
      timeSeconds: ($taskbar.time.seconds_enabled // false),
      launcherIcon: ($taskbar.icons.launcher_custom_icon_path //
        if ($appearance.theme // "") == "argvus-dark" then "/usr/share/argvus/svg/menu-default-dark.svg"
        elif ($appearance.theme // "") == "argvus-light" then "/usr/share/argvus/svg/menu-default-light.svg"
        else $launcher end),
      fontFamily: $fonts.taskbar.family,
      fontSize: $fonts.taskbar.size,
      background: ($bar_colors["th-background"] // "#252830"),
      opacity: transparency("taskbar"; 15),
      foreground: $bar_colors["th-foreground"],
      accent: $bar_colors["th-decorate"],
      groupBorder: ($bar_colors["th-border-rights"] | qt_rgba),
      windowForeground: $bar_colors["th-window-fg"],
      powerForeground: $bar_colors["th-power"],
      mediaBackground: ($bar_colors["th-mpris-bg"] | qt_rgba),
      mediaBorder: ($bar_colors["th-mpris-border"] | qt_rgba),
      utilityBackground: $bar_colors["th-right02-bg"],
      systemBackground: $bar_colors["th-right1-bg"],
      danger: $bar_colors["th-danger"],
      warning: $bar_colors["th-warn"],
      paused: $bar_colors["th-recording-pause"],
      secondaryForeground: $bar_colors["th-foreground2"],
      animations: (if $effects.animations == false then false else true end)
    },
    telemetry: {
      marginTop: ([0, (($win.gaps_out_top // 0) - (if $bar.position != "bottom" then ($bar.margin_bottom // 0) else 0 end))] | max),
      marginLeft: ($win.gaps_out_left // 0),
      marginBottom: ([0, (($win.gaps_out_bottom // 0) - (if $bar.position == "bottom" then ($bar.margin_top // 0) else 0 end))] | max),
      fontFamily: $fonts.sysinfo.family,
      fontSize: $fonts.sysinfo.size,
      background: ($telemetry_colors["th-window-bg"] // "#333942"),
      opacity: transparency("widget-telemetry"; 65),
      transparencyEnabled: ($effects["transparency_widget-telemetry_enabled"] != false),
      foreground: $telemetry_colors["th-foreground"],
      accent: $telemetry_colors["th-header"]
    }
  }')
temporary=$(mktemp "$runtime/.presentation.XXXXXX")
trap 'unlink "$temporary" 2>/dev/null || :' EXIT
printf '%s\n' "$snapshot" > "$temporary"
mv -f -- "$temporary" "$runtime/presentation.json"
