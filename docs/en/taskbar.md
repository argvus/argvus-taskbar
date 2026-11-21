---
title: Taskbar
description: Use the ARGVUS Quickshell taskbar.
---

Taskbar and Widget Telemetry are independent surfaces in the Quickshell process managed by `argvus-bars.service`. Use `argvus-taskbar.service` and `argvus-widget-telemetry.service` to control each surface.

It communicates workspaces, focused-window state, clock and calendar access, network, Bluetooth, audio/media, notifications, storage, recording, keep-awake and power/session actions. The exact status modules can be affected by installed providers and hardware.

The leftmost icon opens `argvus launcher`. It is disabled by default. When enabled, it follows the active theme: the theme build renders it in the theme's highlight colour (`taskbar/menu.svg`, from the `taskbar-menu` template of this package), while the built-in ARGVUS Dark/ARGVUS Light themes use `menu-default-dark.svg`/`menu-default-light.svg` (both provided by `argvus-branding`). Use **Control Center → Appearance → Taskbar → Icons → Launcher** to enable/disable it or to pick a custom icon image, which overrides the theme icon.

The taskbar is not the Control Panel. The bar communicates persistent desktop state and status; the Control Panel is an expandable quick-action surface. Calendar and removable-device popups are companion applications/surfaces, not separate taskbars.

Clicking **Memory** or **CPU** opens `btop` inside the themed ARGVUS monitor panel, with an `ARGVUS` header and an `Esc Close` footer. The bottom Kitty tab shows the localized `Press q to close` hint. Press `q` or `Esc` to close. The CPU temperature module opens the live `argvus sensors` overview, grouped by chip. The GPU temperature module appears when a supported GPU and `btop` are available; it shows the highest attributable GPU temperature or `N/A`, and clicking it opens GPU-only btop panels in the same themed frame. btop supports up to six GPU boxes. NVIDIA metrics need its GPU support and NVML, AMD metrics need ROCm SMI, and Intel metrics need readable sysfs interfaces. GPU temperature is shown only when the system exposes a reading linked to that device; Intel temperature is not available from btop 1.4.7. When btop cannot render a GPU box because support or a provider is missing, the ARGVUS panel reports that metrics are unavailable. ARGVUS does not change system permissions.

## Position and spacing

The default position is the top edge in dock mode. Control Center exposes taskbar position and taskbar/shell margins under **Appearance → Taskbar → Position** and **Spaces**, and the utility group under **Appearance → Taskbar → Icons**. The layout state stores independent top, left, right and bottom margins. Sticky mode defaults the bottom margin to `2` and keeps the bar close to the edge; Spaced mode uses a default `18`-unit shell margin.

Taskbar margin, window outer gap and panel geometry are related but distinct. Changing one does not rewrite every other value. If a bar appears visually detached from windows, review the mode, taskbar margins and window spacing together; see [Windows and layout](/docs/argvus-hyprland/windows-and-layout/).

The taskbar position control currently selects **Top** or **Bottom**. The four independent margins control how far the bar sits from each screen edge. The utility group can use **Auto** or **Always expanded** behavior. Module availability still depends on the installed provider and hardware, so a missing Bluetooth, brightness or storage indicator is not created by changing bar spacing.

**Height** sets the bar height to 24 (the default), 28, 32 or 36 pixels. **Border** turns the taskbar border on or off and sets its thickness to 1, 2 or 3 pixels. The thickness applies to the taskbar window, the `right-0`, `right-1`, `focus` and `right-2` groups, and the MPRIS player border. The active workspace is shown in inverted colours on a rectangular background. Tooltips use the active theme’s colours and typeface. With the border off, those borders are written as `0px`. Both are drafts in **Control Center → Appearance → Taskbar** until **[ Apply ]** is selected.

**Control Center → Appearance → Taskbar → Icons → Optional modules** controls the visibility of optional status and action modules. Workspaces, the focused-window title, Settings and Power remain available. **Workspace presentation** selects workspace labels (the default) or application icons. MPRIS players show track details in their tooltips; the player no longer uses a continuous color pulse.

## Transparency and blur

Use **Control Center → Appearance → Taskbar** to configure Utility Icons, Transparency and Blur. Transparency and Blur each have an enable switch and a `0–100%` value. Change values with `+` and `-` in 5% steps; changes are drafts until **[ Apply ]** is selected. New themes default to both effects enabled at `50%`.
Use `↑/↓` to move between the enable and value rows. Press `Tab` for **Actions**, then activate **[ Apply ]**.

## Configuration and overrides

`argvus config`: `/layout/taskbar`, `/taskbar`, `/fonts/targets/taskbar`.

`$XDG_RUNTIME_DIR/argvus/bars/presentation.json` ← `argvus sessionctl bars-presentation`.

## Windows and panels

The taskbar is one shell surface alongside the Control Panel and optional telemetry widget. Hyprland arranges windows according to the active layout state, while these surfaces have their own anchors and margins. `SUPER + SHIFT + Space` toggles the focused window between tiled and floating layouts.

## Clock and Focus

The time module (`clock#time`) opens or hides the ARGVUS Clock popup and passes its root click coordinates so it can align with the clicked taskbar and monitor. The Focus indicator has its own `focus` group between the network/performance group (`right-1`) and date/time (`right-0`). It runs `argvus focus status --waybar --follow` without loading GTK: while idle it shows the timer icon, and during a focus or break phase it adds the remaining `MM:SS`; its color identifies the phase and paused state. Clicking it opens or hides the Focus popup at that click position. Both popups also close with **Esc** or a click outside.

## Reloading

The main service is `argvus-taskbar.service`. When a documented configuration change requires a manual reload, use the session controller:

```sh
argvus sessionctl restart taskbar
```

Calendar and removable-storage popups use the immutable root-coordinate contract provided by the ARGVUS Quickshell build to identify the monitor. The calendar follows the real horizontal Taskbar surface: it opens 4 pixels below a top bar or 4 pixels above a bottom bar, regardless of where inside the date module it was clicked; the date module opens the calendar. Do not edit generated runtime configuration to make persistent changes; use Control Center or the documented path.

Utilities collapse to an expander in hover mode and reveal enabled controls on pointer entry. System tray visibility controls background application icons; an empty tray has no visible icons. Workspace icon presentation shows application icons for open windows alongside workspace labels.

## Project workspaces

Open projects appear as ordinary workspace buttons, labelled `Project: name`; clicking one focuses it. Hover shows the full project path and `SUPER + ALT + N` shortcut. Only open workspaces on the bar's monitor are displayed; the picker (`SUPER + O`) remains the full project catalog. Special workspaces keep their existing visibility policy.

`$XDG_RUNTIME_DIR/argvus/project-workspaces.json` · `argvus projects`

The **Update Status** module has its own group between Utilities and network/performance and shows the number of available package updates. It checks official repositories on startup and hourly using `checkupdates` (from `pacman-contrib`), without upgrading packages. **Check AUR** is off by default; when enabled, it checks with `paru` or `yay`. The tooltip separates sources and reports failures; `?` means the total is incomplete. Click the module to open official updates in Packages. Configure both options under **Icons → Optional modules** and apply the taskbar draft. The module is enabled by default.

The taskbar network indicator follows NetworkManager events using `argvus networkctl waybar --follow`, with an initial snapshot and automatic monitor reconnection. It no longer waits for a 10-second polling interval. Connected, limited Internet access and disconnected remain distinct states. Wi-Fi status reads cached access points without requesting a scan. `argvus networkctl waybar` emits a single Waybar JSON snapshot.

After package operations in the Control Center finish (including official and AUR upgrades), the taskbar automatically checks the remaining updates without restarting. It also checks after failures, since some packages may already have changed. The hourly check remains enabled; operations outside the Control Center are detected by that periodic check.

### Monitor-local workspace navigation

Next/previous cycles existing numeric workspaces, then named workspaces and projects in native-name order, on the focused monitor only. Taskbar scrolling uses the monitor under the pointer. Cycling wraps; special workspaces are excluded and an open special workspace pauses navigation. Numeric shortcuts retain global IDs. Assignments remain in `/displays/workspaces`.

`argvus config workspace-cycle next|previous [--monitor focused|cursor]`

**Power → ARGVUS Lifecycle** (`argvus-lifecycle`)

Clipboard is enabled by default. Open it from the taskbar utility group. To stop recording text and images, clear the Clipboard option under Control Center → Appearance → Taskbar → Icons → Optional modules and select Apply. This also hides the icon and blocks opening history. Re-enable the option to access previously saved entries.

Browser playback appears only when the player identifies Spotify as the source. Hover tips use a borderless background.

If the check fails, the taskbar retries after 30 seconds.

Click Clipboard or AI Agents in the taskbar to open its panel. Click the same icon again to close it.
