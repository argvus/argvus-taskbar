---
title: Taskbar
description: ARGVUS Waybar.  ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﻡﺪﺨﺘﺳﺍ
---

The leftmost icon opens 

```sh
argvus sessionctl restart waybar
```

. It is disabled by default. When enabled, it follows the active theme: the theme build renders it in the theme's highlight colour (argvus-taskbar, from the argvus-waybar template of this package), while the built-in ARGVUS Dark/ARGVUS Light themes use argvus-session/argvus launcher (both provided by taskbar/menu.svg). Use **Control Center → Appearance → Taskbar → Icons → Launcher** to enable/disable it or to pick a custom icon image, which overrides the theme icon.



Clicking **Memory** or **CPU** opens 

 inside the themed ARGVUS monitor panel, with an argvus-taskbar header and an argvus-waybar footer. The bottom Kitty tab shows the localized argvus-session hint. Press argvus launcher or taskbar/menu.svg to close. The CPU temperature module opens the live taskbar-menu overview, grouped by chip. The GPU temperature module appears when a supported GPU and menu-default-dark.svg are available; it shows the highest attributable GPU temperature or menu-default-light.svg, and clicking it opens GPU-only btop panels in the same themed frame. btop supports up to six GPU boxes. NVIDIA metrics need its GPU support and NVML, AMD metrics need ROCm SMI, and Intel metrics need readable sysfs interfaces. GPU temperature is shown only when the system exposes a reading linked to that device; Intel temperature is not available from btop 1.4.7. When btop cannot render a GPU box because support or a provider is missing, the ARGVUS panel reports that metrics are unavailable. ARGVUS does not change system permissions.

## 

18.









##                                                              ﺶﻳﻮﺸﺘﻟﺍﻭ ﺔﻴﻓﺎﻔﺸﻟﺍ

Use **Control Center → Appearance → Taskbar** to configure Utility Icons, Transparency and Blur. Transparency and Blur each have an enable switch and a 0–100% value. Change values with + and - in 5% steps; changes are drafts until **[ Apply ]** is selected. New themes default to both effects enabled at 50%.
.**[ ﻖﻴﺒﻄﺗ ]** ﻞّﻌﻓ ﻢﺛ ،**

## ﺕﺍﺯﻭﺎﺠﺘﻟﺍﻭ ﺔﺌﻴﻬﺘﻟﺍ

The taskbar configuration is owned by 


##                                                                ﺡﺍﻮﻟﻷ﻿ﺍﻭ ﺬﻓﺍﻮﻨﻟﺍ

.ﻢﺋﺎﻌﻟﺍ ﻂﻴﻄﺨﺘﻟﺍﻭ ﻁﻼ﻿ﺒﻟﺍ ﺕﺎﻄﻴﻄﺨﺗ ﻦﻴﺑ ﺓﺰﻛﺮﻤﻟﺍ ﺓﺬﻓﺎﻨﻟﺍ ﻞﻳﺪﺒﺘﺑ   `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus launcher`  `taskbar/menu.svg`  `taskbar-menu`  `menu-default-dark.svg`  `menu-default-light.svg`  `argvus-branding`  `btop` `ARGVUS`  null  argvus config  /taskbar/shape/border_width  /taskbar/shape/height  right-2  ~/.config/argvus/data/generated/waybar/  argvus-config  argvus-session  argvus-waybar  argvus-taskbar  Tab  ↑/↓  50%  -  +  0–100%  0px  right-2  focus  right-1  right-0  18  2  N/A  btop  argvus sensors  Esc  q  Press q to close  `Esc Close` `Press q to close` `q`  `Esc`  `argvus sensors`  `btop`  `N/A`  `2`  `18`  argvus-waybar  argvus projects  $XDG_RUNTIME_DIR  workspace-metadata: "argvus/project-workspaces.json"  hyprland/workspaces  SUPER + O  SUPER + ALT + N  Project: name  argvus-taskbar.service  MM:SS  argvus focus status --waybar --follow  `right-0`  `right-1`  `focus`   `right-2`  `0px`  `0–100%`  `+`  `-`  `50%`  `↑/↓`  `Tab`  `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus-config`  `~/.config/argvus/data/generated/waybar/`  `right-2`  `/taskbar/shape/height`  `/taskbar/shape/border_width`  `argvus config`  `null`  `~/.config/waybar/`  `SUPER + SHIFT + Space` `clock#time` `focus`  `right-1`  `right-0`  `argvus focus status --waybar --follow`  `MM:SS`  `argvus-taskbar.service`  `Project: name`  `SUPER + ALT + N`  `SUPER + O`  `hyprland/workspaces`  `workspace-metadata: "argvus/project-workspaces.json"`  `$XDG_RUNTIME_DIR`  `argvus projects`  `argvus-waybar`  `checkupdates`  `pacman-contrib`  `paru`  `yay`  `?`  `argvus networkctl waybar --follow`  `argvus networkctl waybar`   ﻡﻮ

##                                                                ﺰﻴﻛﺮﺘﻟﺍﻭ ﺔﻋﺎﺴﻟﺍ



## Reloading

## 







Waybar.


 for the installed and user paths. for the installed and user paths.(/docs/argvus-waybar/) path.

ﺮﻈﻧﺍ ؛ﺎًﻌﻣ ﺬﻓﺍﻮﻨﻟﺍ ﺪﻋﺎﺒﺗﻭ ،ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﺶﻣﺍﻮﻫﻭ ،ﻊﺿﻮﻟﺍ ﻊﺟﺍﺮﻓ ،ﺬﻓﺍﻮﻨﻟﺍ ﻦﻋ ﺎًﻳﺮﺼﺑ ﺎًﻠ[                                                              ﻂﻴﻄﺨﺘﻟﺍﻭ ﺬﻓﺍﻮﻨﻟﺍ](/docs/argvus-hyprland/windows-and-layout/).
The taskbar configuration is owned by argvus-taskbar, rendered by argvus-waybar and started by argvus-session. argvus-config is the only component that writes the taskbar consumer files: it projects the active layer under ~/.config/argvus/data/generated/waybar/ and reapplies the theme layer, taskbar margins, right-2 utility-group mode, border radius and the font block whenever themes or layout state change. A theme switch also restores the packaged taskbar files and then writes back the height and border chosen in Control Center, which are stored as /taskbar/shape/height and /taskbar/shape/border_width in argvus config. Until one is chosen it is null and follows the theme: 28 px high, with a 1 px border (Slate Dark has none). Because the generated copy is resolved first, a native Waybar path under ~/.config/waybar/ only takes effect while the corresponding generated file is absent. See [Waybar and taskbar overrides](/docs/argvus-waybar/) for precedence, examples and troubleshooting.
ﺎًﻤﺋﺍﺩ ﻪﻠﻌﺠﻟ ﺪﻟﻮﻤﻟﺍ ﻞﻴﻐﺸﺘﻟﺍ ﺖﻗﻭ ﻦﻳﻮﻜﺗ ﺮﻳﺮﺤﺘﺑ ﻢﻘﺗ ﻻ﻿ .ﻢﻳﻮﻘﺘﻟﺍ ﺦﻳﺭﺎﺘﻟﺍ ﺓﺪﺣﻭ ﺢﺘﻔﺗ ؛                                      ﺪﻨﺘﺴﻤﻟﺍ ﻭﺃ ﻢﻜﺤﺘﻟﺍ ﺰﻛﺮﻣ ﻡﺪﺨﺘﺳﺍ ؛ﺕﺍﺮﻴﻴﻐﺘﻟﺍ[                                                                  ﺭﺎﺒﻳﺍﻭ ﺯﻭﺎﺠﺗ](/docs/argvus-waybar/)                                                                         .ﺭﺎﺴﻣ
