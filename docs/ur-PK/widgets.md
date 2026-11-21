---
title: وجیٹس
description:                                    ۔ﮟﯾﺩ ﺐﯿﺗﺮﺗ ﻮﮐ ﺲﭩﯿﺟﻭ ﯼﺮﭩﯿﻣ ﯽﻠﯿﭨ ﻢﭩﺴﺳ ﯼﺭﺎﯿﺘﺧﺍ
---

`argvus widget-telemetry` ﮯﮨ ﺎﺗﺎﺟ ﺎﯿﮐ ﻅﻮﻔﺤﻣ ﮫﺗﺎﺳ ﮯﮐ ﺪﯿﻠﮐ ﮎﻼ﻿ﺑ ﺲﭩﮐ ﭦﺭﺎﺷ ۔**ﺲﭩﮐ ﭦﺭﺎﺷ** ﺭﻭﺍ **ﮎﺭﻭ ﭧﯿﻧ** ،**`keys` in the state file.



ٹاسک بار اور ٹیلی میٹری ویجیٹ `argvus-bars.service` کے زیر انتظام Quickshell عمل کی الگ سطحیں ہیں۔ ہر سطح کو `argvus-taskbar.service` اور `argvus-widget-telemetry.service` سے کنٹرول کریں۔

`/effects/widget_telemetry_enabled` · `widget-telemetry-blocks`

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

`argvus widget-telemetry toggle blocks set <block> <enabled|disabled>` · `argvus widget-telemetry toggle apply-state`

۔ﮯﮨ ﺎﺘﮨﺭ ﺭﺍﺮﻗﺮﺑ ﻥﺎﯿﻣﺭﺩ ﮯﮐ ﻥﺍ ﮒﻻ﻿ ﺏﺎﺨﺘﻧﺍ ۔ﮟﯿﮭﺗ ﮓﻨﭨﻮﻠﻓ ﮟﯿﻣ ﻞﺻﺍ ﻮﺟ ﮟﯿﮨ ﯽﺘﮨﺭ ﻅﻮﻔﺤﻣ



## ﺭﺎﺑ ﯽﮐ ﺖﺳﺍﻮﺧﺭﺩ ﺭﻭﺍ ﻦﭩﺑ ﻭﮉﻧﻭ





`argvus window-mode-menu` · `argvus window-mode-menu --status`

مائنسائزیشن محفوظ استعمال کرتا ہے۔

کام کی جگہ اس ورک اسپیس کو دستی طور پر استعمال نہ کریں۔ `special:argvus-minimized` پروسیس شناخت، اصل ورک اسپیس/مانیٹر، جیومیٹری، فل سکرین/زیادہ سے زیادہ اور پن کی حالت کو `argvus windows service` کے تحت کمپوزیٹر-انسٹانس-مخصوص رن ٹائم رجسٹری میں ریکارڈ کرتا ہے۔ ریکارڈز سروس کے دوبارہ شروع ہونے یا تشکیل دوبارہ لوڈ کرنے سے بچ جاتے ہیں، لیکن کمپوزیٹر سیشنز کو عبور نہیں کرتے ہیں۔ ونڈو کو بند کرنے سے اس کا ریکارڈ ختم ہوجاتا ہے۔ اگر ایک مانیٹر غائب ہو جاتا ہے، بحالی ایک دستیاب آؤٹ پٹ کا استعمال کرتا ہے. ایک گمشدہ یا ناکام ریکوری بار نئی مائنسائزیشن کو روکتا ہے۔ ناکام بحالی ریکارڈ اور ریکوری بار کو برقرار رکھتی ہے۔



Commands:

, `$XDG_RUNTIME_DIR/argvus`، `argvus-windows.service`، `argvus-window-bar.service`، اور `argvus-hyprland`۔ ونڈو کے پتے فہرست سے آتے ہیں۔ `argvus windows list --json` پوزیشن ٹاپ --persist minimize|restore|activate|maximize|close ADDRESS restore-all position top|bottom `watch --json` `position top|bottom` `restore-all` `minimize|restore|activate|maximize|close ADDRESS` `position top --persist` اسٹورز کی پریفرنسنگ کے بغیر مین بار/پرو۔ کنفیگریشن اور رن ٹائم غلطی کی تفصیلات جرنل میں لکھی جاتی ہیں۔ مرئی کارروائی کی ناکامیاں بھی ترجمہ شدہ اطلاع دکھاتی ہیں۔

In **Spaced + Floating**، ۔ﮯﮨ ﺎﺘﮭﭩﯿﺑ ﺭﺪﻧﺍ ﮯﮐ ﺭﮈﺭﺎﺑ ﻭﮉﻧﻭ ﯽﺳﺍ ﻮﺟ ،ﮟﯿﮨ ﻞﻣﺎﺷ ﻞﭩﺋﺎﭨ
