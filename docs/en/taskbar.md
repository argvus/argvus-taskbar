---
title: Taskbar
description: Use the ARGVUS Waybar taskbar.
---

The taskbar is the persistent Waybar surface across the desktop. `argvus-taskbar` owns its ARGVUS configuration and actions; `argvus-waybar` provides the patched Waybar binary that renders it. `argvus-session` owns the service lifecycle.

It communicates workspaces, focused-window state, clock and calendar access, network, Bluetooth, audio/media, notifications, storage, recording, keep-awake and power/session actions. The exact status modules can be affected by installed providers and hardware.

The leftmost icon opens `argvus-launcher`. It is disabled by default. When enabled, it follows the active theme: each `argvus-theme-*` package ships its own `/usr/share/argvus/svg/menu-<id>.svg`, while the built-in ARGVUS Dark/ARGVUS Light themes use `menu-default-dark.svg`/`menu-default-light.svg` (both provided by `argvus-branding`). Use **Control Center → Appearance → Taskbar → Icons → Launcher** to enable/disable it or to pick a custom icon image, which overrides the theme icon.

The taskbar is not the Control Panel. The bar communicates persistent desktop state and status; the Control Panel is an expandable quick-action surface. Calendar and removable-device popups are companion applications/surfaces, not separate taskbars.

## Position and spacing

The default position is the top edge in dock mode. Control Center exposes taskbar position, taskbar/shell margins and the utility group under **Appearance → Spaces, Borders & Position**. The layout state stores independent top, left, right and bottom margins. Sticky mode keeps the bar close to the edge; Float mode uses a default `18`-unit shell margin.

Taskbar margin, window outer gap and panel geometry are related but distinct. Changing one does not rewrite every other value. If a bar appears visually detached from windows, review the mode, taskbar margins and window spacing together; see [Windows and layout](/docs/argvus-hyprland/windows-and-layout/).

The taskbar position control currently selects **Top** or **Bottom**. The four independent margins control how far the bar sits from each screen edge. The utility group can use **Auto** or **Always expanded** behavior. Module availability still depends on the installed provider and hardware, so a missing Bluetooth, brightness or storage indicator is not created by changing bar spacing.

## Transparency and blur

Use **Control Center → Appearance → Taskbar** to configure Utility Icons, Transparency and Blur. Transparency and Blur each have an enable switch and a `0–100%` value. Change values with `+` and `-` in 5% steps; changes are drafts until **[ Apply ]** is selected. New themes default to both effects enabled at `50%`.
Use `↑/↓` to move between the enable and value rows. Press `Tab` for **Actions**, then activate **[ Apply ]**.

## Configuration and overrides

The taskbar configuration is owned by `argvus-taskbar`, rendered by `argvus-waybar` and started by `argvus-session`. `argvus-config` is the only component that writes the taskbar consumer files: it projects the active layer under `~/.config/argvus/data/generated/waybar/` and reapplies the theme layer, taskbar margins, `right-2` utility-group mode, border radius and the font block whenever themes or layout state change. Because the generated copy is resolved first, a native Waybar path under `~/.config/waybar/` only takes effect while the corresponding generated file is absent. See [Waybar and taskbar overrides](/docs/argvus-waybar/) for precedence, examples and troubleshooting.

## Windows and panels

The taskbar is one shell surface alongside the Control Panel and optional telemetry widget. Hyprland arranges windows according to the active layout state, while these surfaces have their own anchors and margins. `SUPER + SHIFT + Space` toggles the focused window between tiled and floating layouts.

## Reloading

The main service is `argvus-taskbar.service`. When a documented configuration change requires a manual reload, use the session controller:

```sh
argvus-sessionctl restart waybar
```

Calendar and removable-storage popups use the immutable root-coordinate contract provided by the ARGVUS Waybar build to identify the monitor. The calendar then follows the real horizontal Taskbar surface: it opens 4 pixels below a top bar or 4 pixels above a bottom bar, regardless of where inside the date module it was clicked. Do not edit generated runtime configuration to make persistent changes; use Control Center or the documented [Waybar override](/docs/argvus-waybar/) path.
