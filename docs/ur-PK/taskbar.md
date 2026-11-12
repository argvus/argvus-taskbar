---
title: ٹاسک بار
description: ARGVUS ۔ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﺭﺎﺑ ﮏﺳﺎﭨ ﺭﺎﺑ ﮮﻭ
---

**میموری** یا **CPU** پر کلک کرنے سے کھل جاتا ہے۔

```sh
argvus sessionctl restart waybar
```

تھیمڈ ARGVUS مانیٹر پینل کے اندر، ایک argvus-ٹاسک بار ہیڈر اور argvus-waybar فوٹر کے ساتھ۔ نیچے کٹی ٹیب مقامی argvus-سیشن اشارہ دکھاتا ہے۔ بند کرنے کے لیے argvus لانچر یا taskbar/menu.svg دبائیں۔ CPU درجہ حرارت ماڈیول لائیو ٹاسک بار مینو کا جائزہ کھولتا ہے، جو چپ کے ذریعے گروپ کیا جاتا ہے۔ GPU درجہ حرارت ماڈیول ظاہر ہوتا ہے جب ایک معاون GPU اور menu-default-dark.svg دستیاب ہوتا ہے۔ یہ سب سے زیادہ منسوب GPU درجہ حرارت یا menu-default-light.svg دکھاتا ہے، اور اس پر کلک کرنے سے اسی تھیم والے فریم میں GPU-only btop پینل کھل جاتے ہیں۔ btop چھ GPU خانوں کو سپورٹ کرتا ہے۔ NVIDIA میٹرکس کو اس کے GPU سپورٹ کی ضرورت ہے اور NVML، AMD میٹرکس کو ROCm SMI، اور Intel میٹرکس کو پڑھنے کے قابل sysfs انٹرفیس کی ضرورت ہے۔ GPU درجہ حرارت صرف اس وقت دکھایا جاتا ہے جب سسٹم اس ڈیوائس سے منسلک ریڈنگ کو ظاہر کرتا ہے۔ Intel درجہ حرارت btop 1.4.7 سے دستیاب نہیں ہے۔ جب btop GPU باکس نہیں دے سکتا کیونکہ سپورٹ یا فراہم کنندہ غائب ہے، ARGVUS پینل رپورٹ کرتا ہے کہ میٹرکس دستیاب نہیں ہیں۔ ARGVUS سسٹم کی اجازتوں کو تبدیل نہیں کرتا ہے۔

##







**اونچائی** بار کی اونچائی کو 24، 28 (پہلے سے طے شدہ)، 32 یا 36 پکسلز پر سیٹ کرتی ہے۔ **بارڈر** ٹاسک بار بارڈر کو آن یا آف کرتا ہے اور اس کی موٹائی کو 1، 2 یا 3 پکسلز پر سیٹ کرتا ہے۔ موٹائی کا اطلاق ٹاسک بار ونڈو پر ہوتا ہے۔

, argvus-ٹاسک بار، argvus-waybar اور argvus-سیشن گروپس، اور MPRIS پلیئر بارڈر۔ پلیئر سمیت انٹرایکٹو ماڈیولز کو منڈلانا ان کی دھندلاپن کو آہستہ سے کم کرتا ہے۔ بارڈر آف ہونے کے ساتھ، وہ بارڈرز کو argvus لانچر کے طور پر لکھا جاتا ہے۔ دونوں **کنٹرول سینٹر → ظاہری شکل → ٹاسک بار** میں ڈرافٹ ہیں جب تک کہ **[ اپلائی کریں ]** کا انتخاب نہ ہوجائے۔



##                                                             ﻦﭘﻻ﻿ﺪﻨﮬﺩ ﺭﻭﺍ ﺖﯿﻓﺎﻔﺷ

یوٹیلیٹی آئیکنز، شفافیت اور دھندلا پن کو کنفیگر کرنے کے لیے **کنٹرول سینٹر → ظاہری شکل → ٹاسک بار** کا استعمال کریں۔ شفافیت اور دھندلاپن میں سے ہر ایک میں ایک قابل سوئچ اور 0-100% قدر ہے۔ + اور - کے ساتھ اقدار کو 5% مراحل میں تبدیل کریں۔ تبدیلیاں ڈرافٹ ہیں جب تک **[ اپلائی کریں ]** کو منتخب نہیں کیا جاتا۔ دونوں اثرات کے لیے نئے تھیمز ڈیفالٹ 50% پر فعال ہیں۔
۔ﮟﯾﺮﮐ ﻝﺎﻌﻓ ﻮﮐ **[

## ﺯﮉﯿﺋﺍﺭ ﺭﻭﻭﺍ ﺭﻭﺍ ﻦﺸﯾﺮﮕﯿﻔﻨﮐ

ٹاسک بار کنفیگریشن کی ملکیت ہے۔


##                                                               ﻞﻨﯿﭘ ﺭﻭﺍ ﮞﺎﯿﮐﮍﮭﮐ

The taskbar is one shell surface alongside the Control Panel and optional telemetry widget. Hyprland arranges windows according to the active layout state, while these surfaces have their own anchors and margins.   `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus launcher`  `taskbar/menu.svg`  `taskbar-menu`  `menu-default-dark.svg`  `menu-default-light.svg`  `argvus-branding`  `btop` `ARGVUS`  null  argvus config  /taskbar/shape/border_width  /taskbar/shape/height  right-2  ~/.config/argvus/data/generated/waybar/  argvus-config  argvus-session  argvus-waybar  argvus-taskbar  Tab  ↑/↓  50%  -  +  0–100%  0px  right-2  focus  right-1  right-0  18  2  N/A  btop  argvus sensors  Esc  q  Press q to close  `Esc Close` `Press q to close` toggles the focused window between tiled and floating layouts.

##                                                                  ﮧﺟﻮﺗ ﺭﻭﺍ ﯼﮍﮭﮔ



## دوبارہ لوڈ ہو رہا ہے۔

۔ﮯﮨ ﯽﺗﺎﮭﮐﺩ ﮫﺗﺎﺳ ﮯﮐ ﺰﻠﺒﯿﻟ

## ﺰﺴﯿﭙﺳﺍ ﮎﺭﻭ ﭧﮑﯿﺟﻭﺮﭘ



The  `q`  `Esc`  `argvus sensors`  `btop`  `N/A`  `2` `18`   `right-0`  `right-1`  `focus`   `right-2`  `0px`  `0–100%`  `+`  `-`  `50%`  `↑/↓`  `Tab`  `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus-config`  `~/.config/argvus/data/generated/waybar/`  `right-2`  `/taskbar/shape/height`  `/taskbar/shape/border_width`  `argvus config`  `null`  `~/.config/waybar/`  `SUPER + SHIFT + Space` `clock#time`  `focus`  `right-1`  `right-0`  `argvus focus status --waybar --follow`  `MM:SS`  `argvus-taskbar.service`  `Project: name`  `SUPER + ALT + N`  `SUPER + O` `hyprland/workspaces` module reads `workspace-metadata: "argvus/project-workspaces.json"`, relative to `$XDG_RUNTIME_DIR`. `argvus projects` regenerates this derived file whenever a project opens. The patched `argvus-waybar` supports Hyprland 0.57 textual workspace addresses and uses the metadata for labels without changing workspace identities. Update all three packages and reproject the taskbar configuration before restarting the service.



ٹاسک بار نیٹ ورک انڈیکیٹر نیٹ ورک مینجر کا استعمال کرتے ہوئے واقعات کی پیروی کرتا ہے۔

ایک ابتدائی سنیپ شاٹ اور خودکار مانیٹر کے دوبارہ کنکشن کے ساتھ۔ اب یہ 10 سیکنڈ کے پولنگ وقفے کا انتظار نہیں کرتا۔ منسلک، محدود انٹرنیٹ تک رسائی اور منقطع الگ الگ ریاستیں رہیں۔ Wi-Fi اسٹیٹس اسکین کی درخواست کیے بغیر کیشڈ رسائی پوائنٹس کو پڑھتا ہے۔ `checkupdates` argvus networkctl waybar argvus networkctl waybar -- فالو کریں؟  yay paru `pacman-contrib` `paru` `yay` `?` `argvus networkctl waybar --follow` `argvus networkctl waybar` ایک Waybar JSON سنیپ شاٹ خارج کرتا ہے۔


انسٹال اور صارف کے راستوں کے لیے۔ انسٹال کردہ اور صارف کے راستوں کے لیے۔(/docs/argvus-waybar/) پاتھ۔

 ﮟﯿﮭﮑﯾﺩ ؛ﮟﯿﮭﮑﯾﺩ ﮫﺗﺎﺳ ﮏﯾﺍ ﻮﮐ ﮯﻠﺻﺎﻓ ﮯﮐ ﻭﮉﻧﻭ ﺭﻭﺍ ﺰﻨﺟﺭﺎﻣ ﮯﮐ ﺭﺎﺒﮑﺳﺎﭨ ،ﮈﻮﻣ ﻮﺗ ،ﮯﮨ ﯽﺗ[                                                               ﺐﯿﺗﺮﺗ ﺭﻭﺍ ﺯﻭﮉﻧﻭ](/docs/argvus-hyprland/windows-and-layout/).
The taskbar configuration is owned by argvus-taskbar, rendered by argvus-waybar and started by argvus-session. argvus-config is the only component that writes the taskbar consumer files: it projects the active layer under ~/.config/argvus/data/generated/waybar/ and reapplies the theme layer, taskbar margins, right-2 utility-group mode, border radius and the font block whenever themes or layout state change. A theme switch also restores the packaged taskbar files and then writes back the height and border chosen in Control Center, which are stored as /taskbar/shape/height and /taskbar/shape/border_width in argvus config. Until one is chosen it is null and follows the theme: 28 px high, with a 1 px border (Slate Dark has none). Because the generated copy is resolved first, a native Waybar path under ~/.config/waybar/ only takes effect while the corresponding generated file is absent. See [Waybar and taskbar overrides](/docs/argvus-waybar/) for precedence, examples and troubleshooting.
۔ﮟﯾﺮﮐ ﮧﻧ ﻢﯿﻣﺮﺗ ﮟﯿﻣ ﻦﺸﯾﺮﮕﯿﻔﻨﮐ ﻢﺋﺎﭨ ﻥﺭ ﮦﺪﺷ ﺍﺪﯿﭘ ﮯﯿﻟ ﮯﮐ ﮯﻧﺎﻨﺑ ﻞﻘﺘﺴﻣ ۔ﮯﮨ ﺎﺘﻟﻮﮭﮐ ﺭﮉ                               ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﯼﺰﯾﻭﺎﺘﺳﺩ ﺎﯾ ﺮﭩﻨﯿﺳ ﻝﻭﺮﭩﻨﮐ ؛ﮞﺎﯿﻠﯾﺪﺒﺗ[                                                              ﮉﯿﺋﺍﺭﺭﻭﻭﺍ ﺭﺎﺑ ﮮﻭ](/docs/argvus-waybar/)                                                                        ۔ﮧﺘﺳﺍﺭ
