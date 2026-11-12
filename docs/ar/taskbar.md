---
title: شريط المهام
description: ARGVUS Waybar.  ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﻡﺪﺨﺘﺳﺍ
---

The leftmost icon opens

```sh
argvus sessionctl restart waybar
```

. يتم تعطيله بشكل افتراضي. عند تمكينه، فإنه يتبع السمة النشطة: تصميم السمة يعرضه بلون تمييز السمة (argvus-شريط المهام، من argvus-waybar قالب هذه الحزمة)، في حين أن ARGVUS الداكن/ARGVUS تستخدم السمات الفاتحة argvus-session/argvus Launcher (كلاهما مقدم من شريط المهام/menu.svg). استخدم **مركز التحكم → المظهر → شريط المهام → الأيقونات → Launcher** لتمكينه/تعطيله أو لاختيار صورة رمز مخصصة، والتي تتجاوز رمز السمة.



Clicking **Memory** or **CPU** opens

 داخل لوحة الشاشة ARGVUS ذات السمة، مع رأس شريط المهام argvus وتذييل argvus-waybar. تعرض علامة التبويب Kitty السفلية تلميح الجلسة argvus المترجم. اضغط على argvus Launcher أو شريط المهام/menu.svg للإغلاق. تفتح وحدة درجة حرارة وحدة المعالجة المركزية نظرة عامة على قائمة شريط المهام المباشرة، مجمعة حسب الشريحة. تظهر وحدة درجة حرارة وحدة معالجة الرسومات عند توفر وحدة معالجة الرسومات المدعومة وmenu-default-dark.svg؛ فإنه يعرض أعلى درجة حرارة منسوبة لوحدة معالجة الرسومات أو Menu-default-light.svg، والنقر عليه يفتح لوحات btop الخاصة بوحدة معالجة الرسومات فقط في نفس الإطار الموضوعي. يدعم btop ما يصل إلى ستة صناديق GPU. تحتاج مقاييس NVIDIA إلى دعم GPU الخاص بها، وتحتاج مقاييس NVML، AMD إلى ROCm SMI، وتحتاج مقاييس Intel إلى واجهات sysfs قابلة للقراءة. تظهر درجة حرارة وحدة معالجة الرسومات فقط عندما يكشف النظام عن قراءة مرتبطة بهذا الجهاز؛ Intel درجة الحرارة غير متوفرة من btop 1.4.7. عندما يتعذر على btop عرض صندوق GPU بسبب فقدان الدعم أو الموفر، تشير لوحة ARGVUS إلى عدم توفر المقاييس. ARGVUS لا يغير أذونات النظام.

##

18.









##                                                              ﺶﻳﻮﺸﺘﻟﺍﻭ ﺔﻴﻓﺎﻔﺸﻟﺍ

استخدم **مركز التحكم → المظهر → شريط المهام** لتكوين أيقونات الأدوات المساعدة والشفافية والتمويه. يحتوي كل من Transparency وBlur على مفتاح تمكين وقيمة 0–100%. قم بتغيير القيم باستخدام + و- في خطوات بنسبة 5%؛ تعتبر التغييرات بمثابة مسودات حتى يتم تحديد **[تطبيق]**. تم تمكين السمات الجديدة بشكل افتراضي لكلا التأثيرين بنسبة 50%.
.**[ ﻖﻴﺒﻄﺗ ]** ﻞّﻌﻓ ﻢﺛ ،**

## ﺕﺍﺯﻭﺎﺠﺘﻟﺍﻭ ﺔﺌﻴﻬﺘﻟﺍ

The taskbar configuration is owned by


##                                                                ﺡﺍﻮﻟﻷ﻿ﺍﻭ ﺬﻓﺍﻮﻨﻟﺍ

.ﻢﺋﺎﻌﻟﺍ ﻂﻴﻄﺨﺘﻟﺍﻭ ﻁﻼ﻿ﺒﻟﺍ ﺕﺎﻄﻴﻄﺨﺗ ﻦﻴﺑ ﺓﺰﻛﺮﻤﻟﺍ ﺓﺬﻓﺎﻨﻟﺍ ﻞﻳﺪﺒﺘﺑ   `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus launcher`  `taskbar/menu.svg`  `taskbar-menu`  `menu-default-dark.svg`  `menu-default-light.svg`  `argvus-branding`  `btop` `ARGVUS`  null  argvus config  /taskbar/shape/border_width  /taskbar/shape/height  right-2  ~/.config/argvus/data/generated/waybar/  argvus-config  argvus-session  argvus-waybar  argvus-taskbar  Tab  ↑/↓  50%  -  +  0–100%  0px  right-2  focus  right-1  right-0  18  2  N/A  btop  argvus sensors  Esc  q  Press q to close  `Esc Close` `Press q to close` `q`  `Esc`  `argvus sensors`  `btop`  `N/A`  `2`  `18`  argvus-waybar  argvus projects  $XDG_RUNTIME_DIR  workspace-metadata: "argvus/project-workspaces.json"  hyprland/workspaces  SUPER + O  SUPER + ALT + N  Project: name  argvus-taskbar.service  MM:SS  argvus focus status --waybar --follow  `right-0`  `right-1`  `focus`   `right-2`  `0px`  `0–100%`  `+`  `-`  `50%`  `↑/↓`  `Tab`  `argvus-taskbar`  `argvus-waybar`  `argvus-session`  `argvus-config`  `~/.config/argvus/data/generated/waybar/`  `right-2`  `/taskbar/shape/height`  `/taskbar/shape/border_width`  `argvus config`  `null`  `~/.config/waybar/`  `SUPER + SHIFT + Space` `clock#time` `focus`  `right-1`  `right-0`  `argvus focus status --waybar --follow`  `MM:SS`  `argvus-taskbar.service`  `Project: name`  `SUPER + ALT + N`  `SUPER + O`  `hyprland/workspaces`  `workspace-metadata: "argvus/project-workspaces.json"`  `$XDG_RUNTIME_DIR`  `argvus projects`  `argvus-waybar`  `checkupdates`  `pacman-contrib`  `paru`  `yay`  `?`  `argvus networkctl waybar --follow`  `argvus networkctl waybar`   ﻡﻮ

##                                                                ﺰﻴﻛﺮﺘﻟﺍﻭ ﺔﻋﺎﺴﻟﺍ



## إعادة التحميل

##







Waybar.


 للمسارات المثبتة والمستخدم. للمسارات المثبتة ومسارات المستخدم.(/docs/argvus-waybar/).

ﺮﻈﻧﺍ ؛ﺎًﻌﻣ ﺬﻓﺍﻮﻨﻟﺍ ﺪﻋﺎﺒﺗﻭ ،ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﺶﻣﺍﻮﻫﻭ ،ﻊﺿﻮﻟﺍ ﻊﺟﺍﺮﻓ ،ﺬﻓﺍﻮﻨﻟﺍ ﻦﻋ ﺎًﻳﺮﺼﺑ ﺎًﻠ[                                                              ﻂﻴﻄﺨﺘﻟﺍﻭ ﺬﻓﺍﻮﻨﻟﺍ](/docs/argvus-hyprland/windows-and-layout/).
تكوين شريط المهام مملوك لـ argvus-taskbar، ويتم تقديمه بواسطة argvus-waybar ويبدأ بواسطة argvus-session. argvus-config هو المكون الوحيد الذي يكتب ملفات المستهلك لشريط المهام: فهو يعرض الطبقة النشطة ضمن ~/.config/argvus/data/generated/waybar/ ويعيد تطبيق طبقة السمة وهوامش شريط المهام ووضع مجموعة الأدوات المساعدة اليمنى-2 ونصف قطر الحدود وكتلة الخط كلما تغيرت السمات أو حالة التخطيط. يستعيد مفتاح السمة أيضًا ملفات شريط المهام المجمعة ثم يعيد كتابة الارتفاع والحدود المختارة في مركز التحكم، والتي يتم تخزينها كـ /taskbar/shape/height و/taskbar/shape/border_width في التكوين argvus. حتى يتم اختيار واحد، يكون خاليًا ويتبع السمة: ارتفاع 28 بكسل، مع حد يبلغ 1 بكسل (لا يحتوي Slate Dark على أي شيء). نظرًا لأنه تم حل النسخة التي تم إنشاؤها أولاً، فإن المسار Waybar الأصلي ضمن ~/.config/waybar/ يصبح ساري المفعول فقط عندما يكون الملف الذي تم إنشاؤه المقابل غائبًا. راجع [Waybar وتجاوزات شريط المهام](/docs/argvus-waybar/) للحصول على الأسبقية والأمثلة واستكشاف الأخطاء وإصلاحها.
ﺎًﻤﺋﺍﺩ ﻪﻠﻌﺠﻟ ﺪﻟﻮﻤﻟﺍ ﻞﻴﻐﺸﺘﻟﺍ ﺖﻗﻭ ﻦﻳﻮﻜﺗ ﺮﻳﺮﺤﺘﺑ ﻢﻘﺗ ﻻ﻿ .ﻢﻳﻮﻘﺘﻟﺍ ﺦﻳﺭﺎﺘﻟﺍ ﺓﺪﺣﻭ ﺢﺘﻔﺗ ؛                                      ﺪﻨﺘﺴﻤﻟﺍ ﻭﺃ ﻢﻜﺤﺘﻟﺍ ﺰﻛﺮﻣ ﻡﺪﺨﺘﺳﺍ ؛ﺕﺍﺮﻴﻴﻐﺘﻟﺍ[                                                                  ﺭﺎﺒﻳﺍﻭ ﺯﻭﺎﺠﺗ](/docs/argvus-waybar/)                                                                         .ﺭﺎﺴﻣ
