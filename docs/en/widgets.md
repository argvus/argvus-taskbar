---
title: Widgets
description: Configure optional system telemetry widgets.
---

`argvus-widget-telemetry` provides an optional auxiliary Waybar surface for system information. Its current blocks are **System**, **CPU/GPU**, **Memory**, **Storage**, **Processes**, **Network** and **Shortcuts**. The Shortcuts block is stored with the key `keys` in the state file.

Use **Control Center → Appearance → Widget Telemetry** to enable the surface and turn individual blocks on or off. Disabling a block hides that telemetry module from the Waybar profile; it does not uninstall a package or stop the rest of the session. The master toggle controls the telemetry surface as a whole.

Block selection is canonical in `config.json`, at `control_panel.widget_telemetry_blocks`, and the master switch is `control_panel.widget_telemetry_enabled`. `argvus-config` projects that selection into the Waybar profile `data/waybar/argvus-widget-telemetry.jsonc` by uncommenting or commenting the lines inside its delimited `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END` blocks, leaving the rest of the file untouched. A legacy `~/.local/state/argvus/widget-telemetry-blocks` file is still read as a migration fallback on older installations, but it is never written. Note that the whole profile is replaced from the packaged default on an appearance change, so the block markers are how the selection survives; text outside them is not preserved across a theme switch.

The controller supports:

```sh
argvus-widget-telemetry-toggle status
argvus-widget-telemetry-toggle on
argvus-widget-telemetry-toggle off
argvus-widget-telemetry-toggle blocks status
argvus-widget-telemetry-toggle blocks set memory disabled
argvus-widget-telemetry-toggle blocks apply
```

The controller also accepts `blocks set <block> <enabled|disabled>` for `system`, `cpu_gpu`, `memory`, `storage`, `processes`, `network` and `keys`. Preferences are persistent; when a block has no explicit preference it follows the enabled default. `blocks set` rewrites the canonical array in a single atomic patch, then reprojects the Waybar profile and reconciles the service lifecycle. `apply-state` is the Control Center's path: it assumes the caller already persisted the selection and only projects it, so never call it with an unpersisted state.

The service is `argvus-widget-telemetry.service` and is managed by `argvus-session`. There is no separate per-block reset button in the current page: enable the block again, or use the provider's supported state management, instead of editing generated Waybar output.

## Transparency and blur

Use **Control Center → Appearance → Widget Telemetry** to configure the master switch, telemetry sessions, Transparency and Blur. Both effects have independent enable switches and `0–100%` values. Use `+` and `-` in 5% steps and select **[ Apply ]**; values are applied only after confirmation and are stored for the active theme.
Use `↑/↓` to move between the enable and value rows. Press `Tab` for **Actions**, then activate **[ Apply ]**.
