---
title: Taskbar
description: ARGVUS ۔ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﺭﺎﺑ ﮏﺳﺎﭨ ﺭﺎﺑ ﮮﻭ
---

Clicking **Memory** or **CPU** opens 

```sh
argvus sessionctl restart waybar
```

 inside the themed ARGVUS monitor panel, with an argvus-taskbar header and an argvus-waybar footer. The bottom Kitty tab shows the localized argvus-session hint. Press argvus launcher or taskbar/menu.svg to close. The CPU temperature module opens the live taskbar-menu overview, grouped by chip. The GPU temperature module appears when a supported GPU and menu-default-dark.svg are available; it shows the highest attributable GPU temperature or menu-default-light.svg, and clicking it opens GPU-only btop panels in the same themed frame. btop supports up to six GPU boxes. NVIDIA metrics need its GPU support and NVML, AMD metrics need ROCm SMI, and Intel metrics need readable sysfs interfaces. GPU temperature is shown only when the system exposes a reading linked to that device; Intel temperature is not available from btop 1.4.7. When btop cannot render a GPU box because support or a provider is missing, the ARGVUS panel reports that metrics are unavailable. ARGVUS does not change system permissions.

## 







**Height** sets the bar height to 24, 28 (the default), 32 or 36 pixels. **Border** turns the taskbar border on or off and sets its thickness to 1, 2 or 3 pixels. The thickness applies to the taskbar window, the 

, argvus-taskbar, argvus-waybar and argvus-session groups, and the MPRIS player border. Hovering interactive modules, including the player, gently lowers their opacity. With the border off, those borders are written as argvus launcher. Both are drafts in **Control Center → Appearance → Taskbar** until **[ Apply ]** is selected.



##                                                             ﻦﭘﻻ﻿ﺪﻨﮬﺩ ﺭﻭﺍ ﺖﯿﻓﺎﻔﺷ

Use **Control Center → Appearance → Taskbar** to configure Utility Icons, Transparency and Blur. Transparency and Blur each have an enable switch and a 0–100% value. Change values with + and - in 5% steps; changes are drafts until **[ Apply ]** is selected. New themes default to both effects enabled at 50%.
۔ﮟﯾﺮﮐ ﻝﺎﻌﻓ ﻮﮐ **[

## ﺯﮉﯿﺋﺍﺭ ﺭﻭﻭﺍ ﺭﻭﺍ ﻦﺸﯾﺮﮕﯿﻔﻨﮐ

The taskbar configuration is owned by 


##                                                               ﻞﻨﯿﭘ ﺭﻭﺍ ﮞﺎﯿﮐﮍﮭﮐ

The taskbar is one shell surface alongside the Control Panel and optional telemetry widget. Hyprland arranges windows according to the active layout state, while these surfaces have their own anchors and margins.   `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus launcher`  `taskbar/menu.svg`  `taskbar-menu`  `menu-default-dark.svg`  `menu-default-light.svg`  `argvus-branding`  `btop` `ARGVUS`  null  argvus config  /taskbar/shape/border_width  /taskbar/shape/height  right-2  ~/.config/argvus/data/generated/waybar/  argvus-config  argvus-session  argvus-waybar  argvus-taskbar  Tab  ↑/↓  50%  -  +  0–100%  0px  right-2  focus  right-1  right-0  18  2  N/A  btop  argvus sensors  Esc  q  Press q to close  `Esc Close` `Press q to close` toggles the focused window between tiled and floating layouts.

##                                                                  ﮧﺟﻮﺗ ﺭﻭﺍ ﯼﮍﮭﮔ



## Reloading

۔ﮯﮨ ﯽﺗﺎﮭﮐﺩ ﮫﺗﺎﺳ ﮯﮐ ﺰﻠﺒﯿﻟ

## ﺰﺴﯿﭙﺳﺍ ﮎﺭﻭ ﭧﮑﯿﺟﻭﺮﭘ



The  `q`  `Esc`  `argvus sensors`  `btop`  `N/A`  `2` `18`   `right-0`  `right-1`  `focus`   `right-2`  `0px`  `0–100%`  `+`  `-`  `50%`  `↑/↓`  `Tab`  `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus-config`  `~/.config/argvus/data/generated/waybar/`  `right-2`  `/taskbar/shape/height`  `/taskbar/shape/border_width`  `argvus config`  `null`  `~/.config/waybar/`  `SUPER + SHIFT + Space` `clock#time`  `focus`  `right-1`  `right-0`  `argvus focus status --waybar --follow`  `MM:SS`  `argvus-taskbar.service`  `Project: name`  `SUPER + ALT + N`  `SUPER + O` `hyprland/workspaces` module reads `workspace-metadata: "argvus/project-workspaces.json"`, relative to `$XDG_RUNTIME_DIR`. `argvus projects` regenerates this derived file whenever a project opens. The patched `argvus-waybar` supports Hyprland 0.57 textual workspace addresses and uses the metadata for labels without changing workspace identities. Update all three packages and reproject the taskbar configuration before restarting the service.



The taskbar network indicator follows NetworkManager events using 

, with an initial snapshot and automatic monitor reconnection. It no longer waits for a 10-second polling interval. Connected, limited Internet access and disconnected remain distinct states. Wi-Fi status reads cached access points without requesting a scan. `checkupdates` argvus networkctl waybar  argvus networkctl waybar --follow  ?  yay  paru  `pacman-contrib` `paru`  `yay`  `?`  `argvus networkctl waybar --follow`  `argvus networkctl waybar`   emits a single Waybar JSON snapshot.


 for the installed and user paths. for the installed and user paths.(/docs/argvus-waybar/) path.

 ﮟﯿﮭﮑﯾﺩ ؛ﮟﯿﮭﮑﯾﺩ ﮫﺗﺎﺳ ﮏﯾﺍ ﻮﮐ ﮯﻠﺻﺎﻓ ﮯﮐ ﻭﮉﻧﻭ ﺭﻭﺍ ﺰﻨﺟﺭﺎﻣ ﮯﮐ ﺭﺎﺒﮑﺳﺎﭨ ،ﮈﻮﻣ ﻮﺗ ،ﮯﮨ ﯽﺗ[                                                               ﺐﯿﺗﺮﺗ ﺭﻭﺍ ﺯﻭﮉﻧﻭ](/docs/argvus-hyprland/windows-and-layout/).
The taskbar configuration is owned by argvus-taskbar, rendered by argvus-waybar and started by argvus-session. argvus-config is the only component that writes the taskbar consumer files: it projects the active layer under ~/.config/argvus/data/generated/waybar/ and reapplies the theme layer, taskbar margins, right-2 utility-group mode, border radius and the font block whenever themes or layout state change. A theme switch also restores the packaged taskbar files and then writes back the height and border chosen in Control Center, which are stored as /taskbar/shape/height and /taskbar/shape/border_width in argvus config. Until one is chosen it is null and follows the theme: 28 px high, with a 1 px border (Slate Dark has none). Because the generated copy is resolved first, a native Waybar path under ~/.config/waybar/ only takes effect while the corresponding generated file is absent. See [Waybar and taskbar overrides](/docs/argvus-waybar/) for precedence, examples and troubleshooting.
۔ﮟﯾﺮﮐ ﮧﻧ ﻢﯿﻣﺮﺗ ﮟﯿﻣ ﻦﺸﯾﺮﮕﯿﻔﻨﮐ ﻢﺋﺎﭨ ﻥﺭ ﮦﺪﺷ ﺍﺪﯿﭘ ﮯﯿﻟ ﮯﮐ ﮯﻧﺎﻨﺑ ﻞﻘﺘﺴﻣ ۔ﮯﮨ ﺎﺘﻟﻮﮭﮐ ﺭﮉ                               ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﯼﺰﯾﻭﺎﺘﺳﺩ ﺎﯾ ﺮﭩﻨﯿﺳ ﻝﻭﺮﭩﻨﮐ ؛ﮞﺎﯿﻠﯾﺪﺒﺗ[                                                              ﮉﯿﺋﺍﺭﺭﻭﻭﺍ ﺭﺎﺑ ﮮﻭ](/docs/argvus-waybar/)                                                                        ۔ﮧﺘﺳﺍﺭ
