---
title: Widgets
description: Configure optional system telemetry widgets.
---

`argvus widget-telemetry` provides an optional auxiliary Quickshell surface for system information. Its current blocks are **System**, **CPU/GPU**, **Memory**, **Storage**, **Processes**, **Network** and **Shortcuts**. The Shortcuts block is stored with the key `keys` in the state file.

Use **Control Center → Appearance → Widget Telemetry** to enable the surface and turn individual blocks on or off. Disabling a block hides that telemetry module from the Quickshell profile; it does not uninstall a package or stop the rest of the session. The master toggle controls the telemetry surface as a whole.

Taskbar and Widget Telemetry are independent surfaces in the Quickshell process managed by `argvus-bars.service`. Use `argvus-taskbar.service` and `argvus-widget-telemetry.service` to control each surface.

`/effects/widget_telemetry_enabled` · `widget-telemetry-blocks`

The controller supports:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```

`argvus widget-telemetry toggle blocks set <block> <enabled|disabled>` · `argvus widget-telemetry toggle apply-state`

The service is `argvus-widget-telemetry.service` and is managed by `argvus-session`. There is no separate per-block reset button in the current page: enable the block again, or use the provider's supported state management, instead of editing generated Quickshell output.

## Transparency and blur

Use **Control Center → Appearance → Widget Telemetry** to configure the master switch, telemetry sessions, Transparency and Blur. Both effects have independent enable switches and `0–100%` values. Use `+` and `-` in 5% steps and select **[ Apply ]**; values are applied only after confirmation and are stored for the active theme.
Use `↑/↓` to move between the enable and value rows. Press `Tab` for **Actions**, then activate **[ Apply ]**.

The GPU temperature module is shown when DRM/sysfs exposes a supported NVIDIA, AMD, or Intel GPU and `btop` is installed. Its value is the highest valid temperature that can be attributed to one of the detected GPUs; when no sensor is exposed, it shows `N/A`. Clicking it opens the GPU-only btop panels in Kitty through `argvus tui-terminal` using the `taskbar-monitor` profile. Press `q` or `Esc` to close; the localized bottom tab says `Press q to close`. btop 1.4.7 supports up to six GPU boxes. NVIDIA metrics require btop GPU support and NVML; AMD requires btop GPU support and ROCm SMI; Intel requires readable sysfs interfaces. NVIDIA nouveau, AMD, and Intel temperatures appear only when a linked hwmon sensor is exposed. ARGVUS does not alter permissions or add privileged helpers. The taskbar package depends on btop; manufacturer providers remain optional.


The optional AI agents icon in group/right-2 opens argvus-ai menu. It is checked every five seconds and hidden when the helper is absent or no agents are available (argvus-ai status --check). Claude is offered as installable when mise is present. Selecting it opens the ARGVUS terminal, installs it in the current user profile if missing, then launches it with its binary directory in the process PATH. No package installation hook is used. Reload the bar to load the updated system configuration; user copies are not overwritten.


The AI launcher uses nf-md-robot (U+F06A9) with Symbols Nerd Font Mono. The appearance projector preserves it in group/right-2 alongside the microphone and audio controls.

## Window mode selector

The window icon in `group/right-2`, after the utility expander, opens a GTK popup with **Tile Windows (Default)** and **Floating Windows**. The current preference is marked. Select an option to apply it immediately; Escape or clicking outside dismisses the popup. The icon reflects the effective mode, with a pending/error style when application has not completed. The popup follows the taskbar position and current theme.

The setting is shared with **Control Center → Desktop & Input → Hyprland → Windows → Mode**. Floating affects all application windows across monitors and workspaces. Returning to Tile preserves windows that were originally floating. The selection persists between logins.

`argvus window-mode-menu` · `argvus window-mode-menu --status`

## Window buttons and application bar

Floating mode adds an ARGVUS title bar with **Minimize**, **Maximize / Restore**, and **Close** to normal application windows. Double-clicking the title bar toggles maximization. The additional decoration is hidden in Tile and fullscreen. Applications that draw their own controls may display both bars; uniform ARGVUS controls are intentional.

A second Quickshell appears on every monitor, on the edge opposite the main taskbar. It lists only the windows of that monitor's current workspace, including its minimized windows. Hidden group tabs do not create extra entries. Minimized entries retain their original monitor/workspace association. Click an inactive window to activate it, an active window to minimize it, or a minimized window to restore it; its context menu offers restore, minimize, maximize/restore and close. Unknown application icons fall back to a window symbol. Activating or restoring an entry preserves the pointer position. The secondary bar uses the effective primary theme (colors, fonts, border and rounding), with its height and mirrored margins on the opposite edge.

`SUPER + Alt + Up` places the main bar at the top and the window bar at the bottom. `SUPER + Alt + Down` does the reverse. Repeating a direction leaves the positions unchanged. Tile has only the main bar. Returning to Tile restores all minimized windows before removing the window bar, and then preserves the original tiled/floating policy.

Minimization uses the reserved `special:argvus-minimized` workspace. Do not use that workspace manually. The `argvus windows service` process records identity, original workspace/monitor, geometry, fullscreen/maximization and pin state in a compositor-instance-specific runtime registry under `$XDG_RUNTIME_DIR/argvus`. Records survive a service restart or config reload, but do not cross compositor sessions. Closing a window removes its record. If a monitor disappears, restoration uses an available output. A missing or failed recovery bar prevents new minimizations; failed restoration retains the record and recovery bar.

The session owns `argvus-windows.service` and `argvus-window-bar.service`. The latter keeps its Quickshell child dormant in Tile. The hyprbars plugin is bundled by `argvus-hyprland`, built for the Hyprland 0.57.0 ABI on x86_64; it is not compiled in the user's home directory. Rebuild the plugin with a compositor ABI update.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, and `minimize|restore|activate|maximize|close ADDRESS`. The window addresses come from the list. `position top --persist` stores/projects the preference without restarting the main bar. Configuration and runtime error details are written to the journal; visible action failures also show a translated notification.

In **Spaced + Floating**, windows respect outer gaps and the areas reserved by both bars. The bounds include the border and title, which sits inside the same window border. Maximizing through ARGVUS controls fills this area with margins; restoring recovers the previous geometry, including after a service restart. Fullscreen still uses the whole output. Floating windows may overlap; tiling inner gaps do not separate them.

Processes refreshes every second and shows the five processes with the highest sum of recent CPU and resident memory percentages.
