---
title: 小工具
description: 配置可选的系统遥测小部件。
---
`argvus widget-telemetry` 提供了一个可选的辅助 Waybar 界面，用于显示系统信息。它当前的模块包括 **系统**、**CPU/GPU**、**内存**、**存储**、**进程**、**网络** 和 **快捷方式**。快捷方式模块在状态文件中以键 `keys` 存储。

使用 **控制中心 → 外观 → 小部件遥测** 来启用该界面，并打开或关闭各个模块。禁用某个模块会将该遥测模块从 Waybar 配置文件中隐藏；它不会卸载软件包或停止其他会话。主开关控制整个遥测界面。

在 `config.json` 和 `control_panel.widget_telemetry_blocks` 中，块选择是标准的，主开关是 `control_panel.widget_telemetry_enabled`。`argvus-config` 通过取消注释或注释其  `data/waybar/argvus-widget-telemetry.jsonc` `ARGVUS_TELEMETRY_<BLOCK>_BEGIN`/`_END` 块内的行，将选择投射到 Waybar 配置文件 data/waybar/argvus-widget-telemetry.jsonc 中，同时保持文件的其余部分不变。旧的 `~/.local/state/argvus/widget-telemetry-blocks` 文件仍然作为较老安装的迁移回退被读取，但永远不会被写入。请注意，整个配置文件在外观更改时会从打包的默认值替换，因此块标记是选择得以保留的方式；块外的文本在主题切换时不会被保留。

控制器支持：

```sh
argvus widget-telemetry-toggle status
argvus widget-telemetry-toggle on
argvus widget-telemetry-toggle off
argvus widget-telemetry-toggle blocks status
argvus widget-telemetry-toggle blocks set memory disabled
argvus widget-telemetry-toggle blocks apply
```
控制器还接受 `blocks set <block> <enabled|disabled>` 对应 `system`、`cpu_gpu`、`memory`、`storage`、`processes`、`network` 和 `keys`。首选项是持久的；当一个块没有明确的首选项时，它遵循启用的默认值。`blocks set` 在单个原子补丁中重写标准数组，然后重新投影 Waybar 配置文件并协调服务生命周期。`apply-state` 是控制中心的路径：它假设调用者已经持久化了选择，仅进行投影，因此永远不要在未持久化状态下调用它。

该服务是 `argvus-widget-telemetry.service`，由 `argvus-session` 管理。目前页面上没有单独的每块重置按钮：再次启用该块，或使用提供者支持的状态管理，而不是编辑生成的 Waybar 输出。

## 透明度和模糊

使用 **控制中心 → 外观 → 小部件遥测** 来配置主开关、遥测会话、透明度和模糊效果。这两种效果都有独立的启用开关和 `0–100%` 值。使用 `+` 和 `-` 以 5% 步长调整，并选择 **[ 应用 ]**；数值仅在确认后应用，并为当前主题存储。
使用 `↑/↓` 在启用行和值行之间切换。按 `Tab` 进入 **操作**，然后激活 **[ 应用 ]**。

当 DRM/sysfs 暴露受支持的 NVIDIA、AMD 或 Intel GPU，并且安装了 `btop` 时，将显示 GPU 温度模块。其值是可以归因于检测到的 GPU 中的最高有效温度；当没有传感器暴露时，它显示 `N/A`。点击它会通过 `argvus tui-terminal` 使用 `taskbar-monitor` 配置文件在 Kitty 中打开仅 GPU 的 btop 面板。按 `q` 或 `Esc` 关闭；本地化底部标签显示 `Press q to close`。btop 1.4.7 支持最多六个 GPU 框。NVIDIA 指标需要 btop GPU 支持和 NVML；AMD 需要 btop GPU 支持和 ROCm SMI；Intel 需要可读的 sysfs 接口。当链接的 hwmon 传感器暴露时，NVIDIA nouveau、AMD 和 Intel 温度才会显示。ARGVUS 不会更改权限或添加特权助手。任务栏包依赖于 btop；制造商提供程序仍为可选。


组/右侧-2 中的可选 AI 代理图标打开 argvus-ai 菜单。它每五秒检查一次，如果助手缺失或没有可用的代理（argvus-ai status --check），则隐藏。当 mise 存在时，Claude 可作为可安装选项提供。选择它会打开 ARGVUS 终端，如果当前用户配置中缺失，则安装它，然后将其二进制目录加入进程 PATH 并启动它。不使用任何软件包安装钩子。重新加载工具栏以加载更新的系统配置；用户副本不会被覆盖。

AI 启动器使用 nf-md-robot (U+F06A9) 与 Symbols Nerd Font Mono。外观投影器在组/右侧-2 中保留它，与麦克风和音频控制一起显示。

## 窗口模式选择器

`group/right-2` 中的窗口图标，在实用程序扩展后，会打开一个 GTK 弹出窗口，显示 **平铺窗口（默认）** 和 **浮动窗口**。当前偏好设置会被标记。选择一个选项即可立即应用；按 Esc 或点击外部可关闭弹出窗口。图标会反映有效模式，当应用尚未完成时，会显示待处理/错误样式。弹出窗口会跟随任务栏位置和当前主题。

此设置与 **控制中心 → 桌面与输入 → Hyprland → 窗口 → 模式** 共享。浮动会影响所有显示器和工作区的应用窗口。返回平铺模式会保留最初为浮动的窗口。此选择在登录之间会保持不变。

助手是 `argvus window-mode-menu`；`argvus window-mode-menu --status` 会发出 Waybar JSON。它由主 `argvus` 包提供。现有的自定义任务栏副本将被保留：从打包模板中添加 `custom/window-mode` 模块定义和组条目以加入，或者使用控制中心。外观投影器在定义存在时会保留模块，即使其他实用程序图标被禁用。

## 窗口按钮和应用程序栏

浮动模式会在普通应用窗口中添加一个带有 **最小化**、**最大化 / 还原** 和 **关闭** 的 ARGVUS 标题栏。双击标题栏可切换最大化。在平铺和全屏模式下，额外的装饰会被隐藏。绘制自己控件的应用程序可能会同时显示两个工具栏；统一的 ARGVUS 控件是有意为之。

在每个显示器上都会出现第二个 Waybar，位于主任务栏的相对边缘。它只列出该显示器当前工作区的窗口，包括已最小化的窗口。隐藏的分组标签不会创建额外的条目。已最小化的条目保持其原始的显示器/工作区关联。点击不活动的窗口以激活它，点击活动窗口以最小化它，或点击已最小化的窗口以恢复它；其上下文菜单提供恢复、最小化、最大化/恢复和关闭选项。未知的应用程序图标将回退为窗口符号。激活或恢复条目会保持指针位置。辅助栏使用有效的主 CSS（颜色、字体、边框和圆角），其高度和边缘镜像边距位于相对边缘。

`SUPER + Alt + Up` 将主栏放在顶部，窗口栏放在底部。`SUPER + Alt + Down` 则相反。重复一个方向将保持位置不变。平铺模式只有主栏。返回到平铺模式会在移除窗口栏之前恢复所有最小化的窗口，然后保留原来的平铺/浮动策略。

最小化使用保留的 `special:argvus-minimized` 工作区。不要手动使用该工作区。`argvus windows service` 进程在特定于合成器实例的运行时注册表下的 `$XDG_RUNTIME_DIR/argvus` 记录身份、原始工作区/显示器、几何形状、全屏/最大化和固定状态。记录在服务重启或配置重新加载后仍然存在，但不会跨合成器会话。关闭窗口会删除其记录。如果显示器消失，恢复将使用可用的输出。缺失或恢复条失败会阻止新的最小化；恢复失败会保留记录和恢复条。

会话拥有 `argvus-windows.service` 和 `argvus-window-bar.service`。后者保持其 Waybar 子项在 Tile 中处于休眠状态。hyprbars 插件由 `argvus-hyprland` 打包，为 x86_64 上的 Hyprland 0.57.0 ABI 构建；它未在用户的主目录中编译。更新合成器 ABI 后重新构建该插件。命令：`argvus windows list --json`、`watch --json`、`position top|bottom`、`restore-all` 和 `minimize|restore|activate|maximize|close ADDRESS`。窗口地址来自列表。`position top --persist` 存储/应用偏好设置而无需重新启动主栏。配置和运行时错误详细信息会记录到日志中；可见的操作失败也会显示翻译后的通知。

在 **Spaced + Floating** 模式下，窗口会遵循外部间隙和两个栏位预留的区域。边界包括边框和标题，标题位于同一窗口边框内。通过 ARGVUS 控制最大化时，会用边距填充该区域；恢复时会恢复之前的几何设置，包括服务重启后。全屏仍然占用整个输出区域。浮动窗口可能重叠；铺砖模式中的内部间隙不会将它们分开。
