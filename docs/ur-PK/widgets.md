---
title: وجیٹس
description:                                    ۔ﮟﯾﺩ ﺐﯿﺗﺮﺗ ﻮﮐ ﺲﭩﯿﺟﻭ ﯼﺮﭩﯿﻣ ﯽﻠﯿﭨ ﻢﭩﺴﺳ ﯼﺭﺎﯿﺘﺧﺍ
---

`argvus widget-telemetry` ﮯﮨ ﺎﺗﺎﺟ ﺎﯿﮐ ﻅﻮﻔﺤﻣ ﮫﺗﺎﺳ ﮯﮐ ﺪﯿﻠﮐ ﮎﻼ﻿ﺑ ﺲﭩﮐ ﭦﺭﺎﺷ ۔**ﺲﭩﮐ ﭦﺭﺎﺷ** ﺭﻭﺍ **ﮎﺭﻭ ﭧﯿﻧ** ،**`keys` in the state file.



Block selection is canonical in `config.json`, at `control_panel.widget_telemetry_blocks`, and the master switch is `control_panel.widget_telemetry_enabled`. `argvus-config` projects that selection into the Waybar profile `data/waybar/argvus-widget-telemetry.jsonc` by uncommenting or commenting the lines inside its delimited `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END` blocks, leaving the rest of the file untouched. A legacy `~/.local/state/argvus/widget-telemetry-blocks` file is still read as a migration fallback on older installations, but it is never written. Note that the whole profile is replaced from the packaged default on an appearance change, so the block markers ۔ﺎﺘﮨﺭ ﮟﯿﮩﻧ ﻅﻮﻔﺤﻣ ﺮﭘ ﮯﻨﻟﺪﺑ ﻢﯿﮭﺗ ﻦﺘﻣ ﺎﮐ ﺮﮨﺎﺑ ﮯﮐ ﻥﺍ ؛ﮯﮨ ﺎﺘﮨﺭ ﯽﻗﺎ

کنٹرولر سپورٹ کرتا ہے:

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```

##                                                             ﻦﭘﻻ﻿ﺪﻨﮬﺩ ﺭﻭﺍ ﺖﯿﻓﺎﻔﺷ


۔ﮟﯾﺮﮐ ﻝﺎﻌﻓ ﻮﮐ **[







۔ﮯﮨ ﺎﺘﮭﮐﺭ ﻅﻮﻔﺤﻣ ﮫﺗﺎﺳ ﮯﮐ ﺰﻟﻭﺮﭩﻨﮐ ﻮﯾﮈﺁ ﺭﻭﺍ ﻥﻮﻓﻭﺮﮑﯿﺋﺎﻣ ﮟﯿﻣ 2-ﭧﺋﺍﺭ/ﭖﻭﺮﮔ ﮯﺳﺍ ﺮﭩﮑﯿﺟﻭ

##                                                                ﺮﭩﮑﯿﻠﺳ ﮈﻮﻣ ﻭﮉﻧﻭ

 Press q to close  Esc  q  taskbar-monitor  argvus tui-terminal  N/A  btop  Tab  ↑/↓  -  +  0–100%  argvus-session  argvus-widget-telemetry.service  apply-state  blocks set  keys  network  processes  storage  memory  cpu_gpu  system  `blocks set <block> <enabled|disabled>`  `system`  `cpu_gpu`  `memory`  `storage`  `processes`  `network`  `keys`  `blocks set`  `apply-state`  `argvus-widget-telemetry.service`  `argvus-session`  `0–100%`  `+`  `-`  `↑/↓`  `Tab`  `btop`  `N/A`  `argvus tui-terminal`  `taskbar-monitor`  `q`  `Esc`  `Press q to close` `group/right-2` ﮏﯾﺍ ،ﺪﻌﺑ ﮯﮐ ﺭﮉﻨﯿﭙﺴﮑﯾﺍ ﯽﭩﯿﻠﯿﭨﻮﯾ ،ﻦﮑﯿﺋﺁ ﻭﮉﻧﻭ ﮟﯿﻣ GTK ﮫﮐ ﭖﺍ ﭖﺎﭘ

۔ﮯﮨ ﺎﺘﮨﺭ ﺭﺍﺮﻗﺮﺑ ﻥﺎﯿﻣﺭﺩ ﮯﮐ ﻥﺍ ﮒﻻ﻿ ﺏﺎﺨﺘﻧﺍ ۔ﮟﯿﮭﺗ ﮓﻨﭨﻮﻠﻓ ﮟﯿﻣ ﻞﺻﺍ ﻮﺟ ﮟﯿﮨ ﯽﺘﮨﺭ ﻅﻮﻔﺤﻣ



## ﺭﺎﺑ ﯽﮐ ﺖﺳﺍﻮﺧﺭﺩ ﺭﻭﺍ ﻦﭩﺑ ﻭﮉﻧﻭ





 custom/window-mode  argvus  argvus window-mode-menu --status  `argvus window-mode-menu`  `argvus window-mode-menu --status`  `argvus`  `custom/window-mode` `SUPER + Alt + Up`                              ۔ﮯﮨ ﺎﺘﮭﮐﺭ ﮯﭽﯿﻧ ﻮﮐ ﺭﺎﺑ ﻭﮉﻧﻭ ﺭﻭﺍ ﺮﭘﻭﺍ ﻮﮐ ﺭﺎﺑ ﯼﺰﮐﺮﻣ`SUPER + Alt + Down`۔ﮯﮨ ﺎﺘﮭﮐﺭ ﺭﺍﺮﻗﺮﺑ ﻮﮐ ﯽﺴﯿﻟﺎﭘ ﮓﻨﭨﻮﻠﻓ/ﮦﺪﺷ ﻞﺋﺎﭨ ﻞﺻﺍ ﺮﮭﭘ ﺭﻭﺍ ،ﮯﺳ ﮯﻧﺎﭩﮨ ﻮﮐ ﺭﺎﺑ ﻭﮉﻧﻭ ﮯ

مائنسائزیشن محفوظ استعمال کرتا ہے۔

کام کی جگہ اس ورک اسپیس کو دستی طور پر استعمال نہ کریں۔ `special:argvus-minimized` پروسیس شناخت، اصل ورک اسپیس/مانیٹر، جیومیٹری، فل سکرین/زیادہ سے زیادہ اور پن کی حالت کو `argvus windows service` کے تحت کمپوزیٹر-انسٹانس-مخصوص رن ٹائم رجسٹری میں ریکارڈ کرتا ہے۔ ریکارڈز سروس کے دوبارہ شروع ہونے یا تشکیل دوبارہ لوڈ کرنے سے بچ جاتے ہیں، لیکن کمپوزیٹر سیشنز کو عبور نہیں کرتے ہیں۔ ونڈو کو بند کرنے سے اس کا ریکارڈ ختم ہوجاتا ہے۔ اگر ایک مانیٹر غائب ہو جاتا ہے، بحالی ایک دستیاب آؤٹ پٹ کا استعمال کرتا ہے. ایک گمشدہ یا ناکام ریکوری بار نئی مائنسائزیشن کو روکتا ہے۔ ناکام بحالی ریکارڈ اور ریکوری بار کو برقرار رکھتی ہے۔



Commands:

, `$XDG_RUNTIME_DIR/argvus`، `argvus-windows.service`، `argvus-window-bar.service`، اور `argvus-hyprland`۔ ونڈو کے پتے فہرست سے آتے ہیں۔ `argvus windows list --json` پوزیشن ٹاپ --persist minimize|restore|activate|maximize|close ADDRESS restore-all position top|bottom `watch --json` `position top|bottom` `restore-all` `minimize|restore|activate|maximize|close ADDRESS` `position top --persist` اسٹورز کی پریفرنسنگ کے بغیر مین بار/پرو۔ کنفیگریشن اور رن ٹائم غلطی کی تفصیلات جرنل میں لکھی جاتی ہیں۔ مرئی کارروائی کی ناکامیاں بھی ترجمہ شدہ اطلاع دکھاتی ہیں۔

In **Spaced + Floating**، ۔ﮯﮨ ﺎﺘﮭﭩﯿﺑ ﺭﺪﻧﺍ ﮯﮐ ﺭﮈﺭﺎﺑ ﻭﮉﻧﻭ ﯽﺳﺍ ﻮﺟ ،ﮟﯿﮨ ﻞﻣﺎﺷ ﻞﭩﺋﺎﭨ
