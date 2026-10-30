---
title: Taskbar
description: Use the ARGVUS Waybar taskbar.
---

The taskbar is the persistent Waybar surface across the desktop. `argvus-taskbar` owns its ARGVUS configuration and actions; `argvus-waybar` provides the patched Waybar binary that renders it. `argvus-session` owns the service lifecycle.

It communicates workspaces, focused-window state, clock and calendar access, network, Bluetooth, audio/media, notifications, storage, recording, keep-awake and power/session actions. The exact status modules can be affected by installed providers and hardware.

The leftmost icon opens `argvus launcher`. It is disabled by default. When enabled, it follows the active theme: the theme build renders it in the theme's highlight colour (`taskbar/menu.svg`, from the `taskbar-menu` template of this package), while the built-in ARGVUS Dark/ARGVUS Light themes use `menu-default-dark.svg`/`menu-default-light.svg` (both provided by `argvus-branding`). Use **Control Center → Appearance → Taskbar → Icons → Launcher** to enable/disable it or to pick a custom icon image, which overrides the theme icon.

The taskbar is not the Control Panel. The bar communicates persistent desktop state and status; the Control Panel is an expandable quick-action surface. Calendar and removable-device popups are companion applications/surfaces, not separate taskbars.

Clicking **Memory** or **CPU** opens `btop` inside the themed ARGVUS monitor panel, with an `ARGVUS` header and an `Esc Close` footer. The bottom Kitty tab names the module and shows its localized close hint. Press `Esc` to close the panel; `q` is passed to `btop` and also exits its view. Temperature modules open the live `argvus sensors` overview, grouped by chip; the GPU continues to use `nvidia-smi` when available and otherwise opens the same overview.

## Position and spacing

The default position is the top edge in dock mode. Control Center exposes taskbar position and taskbar/shell margins under **Appearance → Taskbar → Position** and **Spaces**, and the utility group under **Appearance → Taskbar → Icons**. The layout state stores independent top, left, right and bottom margins. Sticky mode defaults the bottom margin to `2` and keeps the bar close to the edge; Float mode uses a default `18`-unit shell margin.

Taskbar margin, window outer gap and panel geometry are related but distinct. Changing one does not rewrite every other value. If a bar appears visually detached from windows, review the mode, taskbar margins and window spacing together; see [Windows and layout](/docs/argvus-hyprland/windows-and-layout/).

The taskbar position control currently selects **Top** or **Bottom**. The four independent margins control how far the bar sits from each screen edge. The utility group can use **Auto** or **Always expanded** behavior. Module availability still depends on the installed provider and hardware, so a missing Bluetooth, brightness or storage indicator is not created by changing bar spacing.

**Height** sets the bar height to 24, 28 (the default), 32 or 36 pixels. **Border** turns the taskbar border on or off and sets its thickness to 1, 2 or 3 pixels. The thickness applies to the taskbar window, the `right-0`, `right-1`, `focus` and `right-2` groups, and the MPRIS player, which also has a hover edge. With the border off, those borders are written as `0px`. Both are drafts in **Control Center → Appearance → Taskbar** until **[ Apply ]** is selected.

## Transparency and blur

Use **Control Center → Appearance → Taskbar** to configure Utility Icons, Transparency and Blur. Transparency and Blur each have an enable switch and a `0–100%` value. Change values with `+` and `-` in 5% steps; changes are drafts until **[ Apply ]** is selected. New themes default to both effects enabled at `50%`.
Use `↑/↓` to move between the enable and value rows. Press `Tab` for **Actions**, then activate **[ Apply ]**.

## Configuration and overrides

The taskbar configuration is owned by `argvus-taskbar`, rendered by `argvus-waybar` and started by `argvus-session`. `argvus-config` is the only component that writes the taskbar consumer files: it projects the active layer under `~/.config/argvus/data/generated/waybar/` and reapplies the theme layer, taskbar margins, `right-2` utility-group mode, border radius and the font block whenever themes or layout state change. A theme switch also restores the packaged taskbar files and then writes back the height and border chosen in Control Center, which are stored as `/taskbar/shape/height` and `/taskbar/shape/border_width` in `argvus config`. Until one is chosen it is `null` and follows the theme: 28 px high, with a 1 px border (Slate Dark has none). Because the generated copy is resolved first, a native Waybar path under `~/.config/waybar/` only takes effect while the corresponding generated file is absent. See [Waybar and taskbar overrides](/docs/argvus-waybar/) for precedence, examples and troubleshooting.

## Windows and panels

The taskbar is one shell surface alongside the Control Panel and optional telemetry widget. Hyprland arranges windows according to the active layout state, while these surfaces have their own anchors and margins. `SUPER + SHIFT + Space` toggles the focused window between tiled and floating layouts.

## Clock and Focus

The time module (`clock#time`) opens or hides the ARGVUS Clock popup and passes its root click coordinates so it can align with the clicked taskbar and monitor. The Focus indicator has its own `focus` group between the network/performance group (`right-1`) and date/time (`right-0`). It runs `argvus focus status --waybar --follow` without loading GTK: while idle it shows the timer icon, and during a focus or break phase it adds the remaining `MM:SS`; its color identifies the phase and paused state. Clicking it opens or hides the Focus popup at that click position. Both popups also close with **Esc** or a click outside.

## Reloading

The main service is `argvus-taskbar.service`. When a documented configuration change requires a manual reload, use the session controller:

```sh
argvus sessionctl restart waybar
```

Calendar and removable-storage popups use the immutable root-coordinate contract provided by the ARGVUS Waybar build to identify the monitor. The calendar follows the real horizontal Taskbar surface: it opens 4 pixels below a top bar or 4 pixels above a bottom bar, regardless of where inside the date module it was clicked; the date module opens the calendar. Do not edit generated runtime configuration to make persistent changes; use Control Center or the documented [Waybar override](/docs/argvus-waybar/) path.
