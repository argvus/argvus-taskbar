pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower

Scope {
    id: root
    // Icon size follows the Control Center font size. Spacing is in pixels.
    readonly property int iconSizeOffset: 1
    readonly property int iconSpacing: 8
    // sizeOffset adjusts the glyph or image. The four margins are outside the button.
    readonly property var iconAdjustments: ({
		launcher: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		workspace: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		spotify: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		media: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		window_title: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		tray: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		expander: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		mode: { sizeOffset: -4, left: 4, right: 4, top: 0, bottom: 0 },
		ai_agents: { sizeOffset: -3, left: 2, right: 2, top: 0, bottom: 0 },
		notifications: { sizeOffset: -2, left: 2, right: 2, top: 0, bottom: 0 },
		removable_devices: { sizeOffset: -2, left: 1, right: 1, top: 0, bottom: 0 },
		recording: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		bluetooth: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		clipboard: { sizeOffset: -3, left: 2, right: 2, top: -2, bottom: 0 },
		audio_input: { sizeOffset: -2, left: 2, right: 2, top: -1, bottom: 0 },
		audio_output: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		keep_awake: { sizeOffset: -3, left: 2, right: 2, top: -1, bottom: 0 },
		update_status: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		network: { sizeOffset: -1, left: 2, right: 2, top: 1, bottom: 0 },
		power_profile: { sizeOffset: -1, left: 2, right: 2, top: 0, bottom: 0 },
		keyboard_layout: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		battery: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		memory: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		cpu: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		cpu_temperature: { sizeOffset: -1, left: 1, right: 1, top: 1, bottom: 0 },
		gpu_temperature: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 },
		focus: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		date: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		clock: { sizeOffset: 0, left: 0, right: 0, top: 0, bottom: 0 },
		power: { sizeOffset: 2, left: 2, right: 2, top: 0, bottom: 0 },
		sidebar: { sizeOffset: 0, left: 2, right: 2, top: 0, bottom: 0 }
    })

    function leadingIcon(text: string): string {
        const code = text.codePointAt(0) ?? 0;
        if (code >= 0xe000 && code <= 0xf8ff)
            return text.slice(0, 1);
        if (code >= 0xf0000 && code <= 0xffffd)
            return text.slice(0, 2);
        if (code >= 0x100000 && code <= 0x10fffd)
            return text.slice(0, 2);
        return "";
    }

    required property var presentation
    property bool displayed: true
    property var layerOrigins: ({})
    readonly property var battery: UPower.displayDevice
    readonly property int batteryPercent: Math.round((battery?.percentage ?? 0) * 100)
    property string sidebarStatePath
    readonly property string dateFormat: presentation.dateFormat ?? "weekday_day_month"
    readonly property var icons: presentation.icons ?? {}
    readonly property var media: Mpris.players.values.find(player => {
        const service = player.dbusName.replace(/^org\.mpris\.MediaPlayer2\./i, "").toLowerCase();
        const app = (player.desktopEntry ?? "").toLowerCase();
        // These native players and verified Spotify web sessions use the Spotify button.
        if (/^(spotify|audacious|rhythmbox|strawberry|lollypop)(\.|$)/.test(service))
            return false;
        const browser = /chrome|chromium|firefox|brave|msedge|microsoft-edge|vivaldi|opera|plasma.browser.integration|kdeconnect|playerctld/;
        if (browser.test(service) || browser.test(app))
            return false;
        const url = String(player.metadata?.["xesam:url"] ?? "");
        if (/^https?:\/\/(?:[^/]+\.)?(?:youtube\.com|youtu\.be|youtube-nocookie\.com)(?:[/:?#]|$)/i.test(url))
            return false;
        const categories = (app ? DesktopEntries.byId(player.desktopEntry)?.categories : null) ?? [];
        return !categories.includes("WebBrowser") && !categories.includes("Video")
            && (categories.includes("Audio") || categories.includes("Music"));
    })
    readonly property var input: Pipewire.defaultAudioSource
    readonly property var output: Pipewire.defaultAudioSink

    PwObjectTracker { objects: [root.input, root.output].filter(node => node != null) }

    readonly property var utilitySpecs: [
        { id: "spotify", command: [script("spotify-mpris")], interval: 5, json: true,
          left: [script("spotify-playpause")], right: [script("spotify-focus")] },
        { id: "mode", command: ["argvus", "window-mode-menu", "--status"], interval: 2, json: true, left: ["argvus", "window-mode-menu"] },
        { id: "ai_agents", command: ["sh", "-c", "command -v argvus-ai >/dev/null && argvus-ai status --check && exec argvus-ai status"], interval: 5, json: true, left: ["argvus-ai", "menu"] },
        { id: "notifications", command: [script("notifications")], interval: 2, json: true, left: ["argvus", "notifications", "dnd", "toggle"] },
        { id: "removable_devices", command: ["argvus", "--removable-devices", "watch"], json: true, stream: true, left: ["/usr/share/argvus/removable-devices/sh/removable-devices-menu.sh", "--root", "{x}", "{y}"] },
        { id: "recording", command: ["/usr/share/argvus/hyprland/sh/hypr-screenshot.sh", "--video-full-status"], interval: 1, json: true, left: ["/usr/share/argvus/hyprland/sh/hypr-screenshot.sh", "--video-full"], right: ["/usr/share/argvus/hyprland/sh/hypr-screenshot.sh", "--video-full-stop"] },
        { id: "bluetooth", command: ["sh", "-c", "argvus bluetooth available && exec argvus bluetooth waybar"], interval: 30, json: true, left: ["argvus", "bluetooth", "toggle"], right: ["argvus", "bluetooth", "manager"] },
        { id: "clipboard", label: "󰅌", command: ["argvus", "i18n", "get", "clipboard", "title"], tooltipOnly: true, left: ["argvus", "clipboard"] },
        { id: "audio_input",
          left: ["argvus", "--control-center", "audio", "input"], right: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle"],
          up: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", "1%+", "-l", "1.0"],
          down: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", "1%-"] },
        { id: "audio_output",
          left: ["argvus", "--control-center", "audio", "output"], right: ["argvus", "config", "audio", "mute", "toggle"],
          up: ["argvus", "config", "audio", "volume", "+2"], down: ["argvus", "config", "audio", "volume", "-2"] },
        { id: "keep_awake", command: [script("keep-awake")], interval: 2, json: true, left: ["/usr/share/argvus/power/sh/keep-awake.sh", "toggle"] }
    ]
    readonly property var rightSpecs: [
        { id: "update_status", command: [script("update-status")], prefix: "󰚰 ", interval: 3600, retryInterval: 30, json: true, left: ["argvus", "control-center", "packages", "updates"] },
        { id: "network", command: ["argvus", "networkctl", "waybar", "--follow"], json: true, stream: true, left: ["argvus", "networkctl", "manager"], right: ["argvus", "networkctl", "toggle"] },
        { id: "keyboard_layout", label: "󰌌", left: ["argvus", "taskbar-actions", "--layout-keyboard"], right: ["argvus", "taskbar-actions", "--layout-keyboard-settings"] },
        { id: "battery" },
        { id: "power_profile" },
        { id: "cpu", label: "", left: ["argvus", "taskbar-actions", "--cpu"] },
        { id: "memory", label: "", left: ["argvus", "taskbar-actions", "--mem"] },
        { id: "cpu_temperature", command: ["sh", "-c", "argvus widget-telemetry block cpu-temp --available && exec argvus widget-telemetry block cpu-temp"], prefix: "", suffix: "°C", interval: 10, left: ["argvus", "taskbar-actions", "--cpu-temp"] },
        { id: "gpu_temperature", command: ["sh", "-c", "argvus widget-telemetry block gpu --available && exec argvus widget-telemetry block gpu --temp"], prefix: "󰢮 ", interval: 15, left: ["argvus", "taskbar-actions", "--gpu-temp"] },
        { id: "focus", command: ["argvus", "focus", "status", "--waybar", "--follow"], stream: true, json: true, left: ["argvus", "focus", "--toggle", "--x", "{x}", "--y", "{y}"] },
        { id: "date", command: [script("date"), dateFormat], prefix: "󰸗 ", interval: 30, left: ["argvus", "taskbar-calendar", "toggle", "--x", "{x}", "--y", "{y}"] }
    ]

    TaskbarMetrics {
        id: metrics
        cpuEnabled: root.icons.cpu_enabled !== false
        memoryEnabled: root.icons.memory_enabled !== false
        keyboardEnabled: root.icons.keyboard_layout_enabled !== false
    }

    Timer {
        id: geometryRefresh
        interval: 200
        onTriggered: layers.running = true
    }

    Process {
        id: layers
        command: ["hyprctl", "-j", "layers"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const origins = {};
                    for (const [output, layers] of Object.entries(JSON.parse(text))) {
                        const bar = [].concat(...Object.values(layers.levels)).find(layer =>
                            layer.namespace === "argvus-taskbar");
                        if (bar)
                            origins[output] = { x: bar.x, y: bar.y };
                    }
                    root.layerOrigins = origins;
                } catch (error) {
                    console.warn("Cannot read ARGVUS bar geometry:", error);
                }
            }
        }
    }

    onPresentationChanged: geometryRefresh.restart()

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent): void {
            if (["monitoradded", "monitorremoved", "configreloaded"].includes(event.name))
                geometryRefresh.restart();
        }
    }

    function indicatorColor(name: string, status: string): color {
        if (status === "error" || status === "bluetooth-off" || status === "recording")
            return presentation.danger ?? "#e06c75";
        if (name === "battery" && batteryPercent <= 30)
            return batteryPercent <= 15 ? (presentation.danger ?? "#e06c75") : (presentation.warning ?? "#e5c07b");
        if (status === "paused")
            return presentation.paused ?? "#e5a0a4";
        if (status === "focus")
            return presentation.accent ?? "#a8c7ff";
        if (status === "short-break" || status === "long-break")
            return presentation.secondaryForeground ?? "#b5bbc6";
        return presentation.foreground ?? "white";
    }

    function batteryLabel(): string {
        if (!battery?.isLaptopBattery || !battery.isPresent)
            return "";
        const icons = ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
        const icon = battery.state === UPowerDeviceState.Charging ? "󰂄"
            : battery.state === UPowerDeviceState.FullyCharged ? "󰁹"
            : !UPower.onBattery ? "󰚥" : icons[Math.max(0, Math.min(10, Math.floor(batteryPercent / 10)))];
        return icon + " " + batteryPercent + "%";
    }

    function batteryTooltip(): string {
        if (!battery?.isLaptopBattery || !battery.isPresent)
            return "";
        const seconds = UPower.onBattery ? battery.timeToEmpty : battery.timeToFull;
        const time = seconds > 0 ? Math.floor(seconds / 3600) + "h " + Math.floor((seconds % 3600) / 60) + "m • " : "";
        return time + battery.changeRate.toFixed(1) + " W";
    }

    function cyclePowerProfile(): void {
        const profiles = [PowerProfile.PowerSaver, PowerProfile.Balanced];
        if (PowerProfiles.hasPerformanceProfile)
            profiles.push(PowerProfile.Performance);
        PowerProfiles.profile = profiles[(profiles.indexOf(PowerProfiles.profile) + 1) % profiles.length];
    }

    function indicatorLabel(indicator: TaskbarIndicator): string {
        switch (indicator.spec.id) {
        case "audio_input":
            return input?.audio ? (input.audio.muted ? "󰍭" : "󰍬") : "";
        case "audio_output":
            if (!output?.audio)
                return "";
            if (output.audio.muted)
                return "";
            const volume = output.audio.volume;
            return volume < 0.33 ? "" : volume < 0.66 ? "" : "";
        case "battery":
            return batteryLabel();
        case "power_profile":
            return PowerProfiles.profile === PowerProfile.Performance ? "󰓅"
                : PowerProfiles.profile === PowerProfile.PowerSaver ? "󰾆" : "󰾅";
        default:
            return [indicator.label, metric(indicator.spec.id)].filter(value => value).join(" ");
        }
    }

    function indicatorTooltip(indicator: TaskbarIndicator): string {
        switch (indicator.spec.id) {
        case "battery": return batteryTooltip();
        case "power_profile": return PowerProfile.toString(PowerProfiles.profile);
        case "audio_input": return input?.audio ? Math.round(input.audio.volume * 100) + "%" : "";
        case "audio_output": return output?.audio ? Math.round(output.audio.volume * 100) + "%" : "";
        default: return indicator.tooltip;
        }
    }

    function metric(id: string): string {
        switch (id) {
        case "cpu": return metrics.cpu;
        case "memory": return metrics.memory;
        case "keyboard_layout": return metrics.keyboard;
        default: return "";
        }
    }

    function script(name: string): string {
        return "/usr/share/argvus/taskbar/sh/waybar-" + name + ".sh";
    }

    function invoke(command: var, x: real, y: real): void {
        if (command)
            Quickshell.execDetached(command.map(arg => arg === "{x}" ? String(Math.round(x))
                : arg === "{y}" ? String(Math.round(y)) : arg));
    }

    property var indicators: ({})

    function refreshUpdates(): void {
        indicators.update_status?.refresh();
    }

    FileView {
        id: sidebar
        path: root.sidebarStatePath
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
    }

    FileView {
        id: projects
        path: Quickshell.env("XDG_RUNTIME_DIR") + "/argvus/project-workspaces.json"
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
    }

    readonly property var projectNames: {
        try {
            return JSON.parse(projects.text());
        } catch (_) {
            return {};
        }
    }

    Instantiator {
        model: root.utilitySpecs.concat(root.rightSpecs)
        onObjectAdded: (_, object) => {
            const item = object as TaskbarIndicator;
            root.indicators = Object.assign({}, root.indicators, { [item.spec.id]: item });
        }
        onObjectRemoved: (_, object) => {
            const entries = Object.assign({}, root.indicators);
            for (const name of Object.keys(entries)) {
                if (entries[name] === object) {
                    delete entries[name];
                    root.indicators = entries;
                    break;
                }
            }
        }
        delegate: TaskbarIndicator {
            required property var modelData

            spec: modelData
            enabled: root.icons[spec.id + "_enabled"] !== false
                && (spec.id !== "spotify" || root.icons.audio_player_enabled !== false)
        }
    }

    SystemClock {
        id: clock
        precision: root.presentation.timeSeconds ? SystemClock.Seconds : SystemClock.Minutes
    }

    Variants {
        model: root.displayed ? Quickshell.screens : []
        delegate: PanelWindow {
            id: bar
            required property ShellScreen modelData
            property bool revealed: false
            readonly property bool expanded: root.presentation.utilityExpanded === true || revealed

            Timer {
                id: revealDelay
                interval: 80
                onTriggered: bar.revealed = true
            }
            readonly property var monitor: Hyprland.monitorFor(modelData)

            screen: modelData
            anchors {
                left: true
                right: true
                top: root.presentation.position !== "bottom"
                bottom: root.presentation.position === "bottom"
            }
            WlrLayershell.namespace: "argvus-taskbar"
            WlrLayershell.margins {
                top: root.presentation.marginTop ?? 0
                right: root.presentation.marginRight ?? 0
                bottom: root.presentation.marginBottom ?? 0
                left: root.presentation.marginLeft ?? 0
            }
            readonly property color backgroundColor: root.presentation.background ?? "#252830"
            readonly property color highlight: root.presentation.accent ?? "#a8c7ff"
            readonly property color groupBorder: paletteColor(root.presentation.groupBorder,
                Qt.rgba(highlight.r, highlight.g, highlight.b, 0.25))
            readonly property int frameHeight: Math.max(0, height - 6)
            readonly property int iconBudget: Math.min(frameHeight, Math.max(1, (root.presentation.fontSize ?? 13) + root.iconSizeOffset)) + root.iconSpacing
            readonly property int frameWidth: root.presentation.borderWidth ?? 1

            function paletteColor(rgba: var, fallback: color): color {
                return rgba ? Qt.rgba(rgba[0], rgba[1], rgba[2], rgba[3]) : fallback;
            }
            color: "transparent"
            implicitHeight: root.presentation.height ?? 24

            Rectangle {
                anchors.fill: parent
                color: Qt.rgba(bar.backgroundColor.r, bar.backgroundColor.g, bar.backgroundColor.b, root.presentation.opacity ?? 0.85)
                radius: root.presentation.radius ?? 0
                border.color: root.presentation.accent ?? "transparent"
                border.width: root.presentation.borderWidth ?? 1
            }

            onWindowConnected: geometryRefresh.restart()

            function invoke(command: var, x: real, y: real): void {
                const origin = root.layerOrigins[modelData.name];
                if (command?.includes("{x}") && !origin)
                    return;
                root.invoke(command, x + (origin?.x ?? 0), y + (origin?.y ?? 0));
            }

            Row {
                id: leftItems
                readonly property int mediaWidth: Math.max(0, Math.min(297,
                    Math.floor((bar.width - rightItems.width - widthWithoutMedia - 24)
                        / Math.max(1, Number(spotifyButton.mediaText !== "") + Number(mediaButton.mediaText !== ""))) - 27 - bar.iconBudget))
                readonly property int widthWithoutMedia: (launcherButton.visible ? launcherButton.width : 0)
                    + workspaceRow.width + 9
                x: bar.frameWidth
                height: parent.height
                StyledButton {
                    id: launcherButton
                    styleKey: "launcher"
                    leftPadding: 6
                    rightPadding: 2
                    label: ""
                    iconPath: root.presentation.launcherIcon ?? "/usr/share/argvus/svg/menu-default-dark.svg"
                    height: leftItems.height
                    visible: root.icons.launcher_enabled !== false
                    onClicked: (_, _, button) => {
                        if (button === Qt.LeftButton)
                            root.invoke(["argvus", "launcher"], 0, 0);
                    }
                }
                Row {
                    id: workspaceRow
                    height: leftItems.height
                    leftPadding: 4
                    rightPadding: 4

                    Repeater {
                        model: Hyprland.workspaces.values.filter(workspace => workspace && workspace.monitor === bar.monitor).sort((a, b) => a.id - b.id)
                        delegate: StyledButton {
                            styleKey: "workspace"
                            required property HyprlandWorkspace modelData

                            height: Math.max(0, workspaceRow.height - 8)
                            y: 4
                            workspace: true
                            bold: true
                            leftPadding: 9
                            workspaceText: bar.backgroundColor
                            readonly property string workspaceLabel: root.projectNames[modelData?.name]?.label ?? modelData?.name ?? ""
                            glyph: root.leadingIcon(workspaceLabel)
                            label: glyph ? workspaceLabel.slice(glyph.length).trim() : workspaceLabel
                            tooltip: root.projectNames[modelData?.name]?.tooltip ?? ""
                            appIcons: root.presentation.workspacePresentation === "app-icons"
                                ? (modelData?.toplevels.values ?? []).map(window =>
                                    Quickshell.iconPath(window?.wayland?.appId ?? "", "application-x-executable"))
                                : []
                            selected: modelData?.active ?? false
                            foreground: modelData?.urgent ? (root.presentation.danger ?? "#e06c75")
                                : (root.presentation.foreground ?? "white")
                            onClicked: (_, _, button) => { if (button === Qt.LeftButton) modelData?.activate(); }
                            onScrolled: direction => root.invoke(["argvus", "config", "workspace-cycle", direction > 0 ? "next" : "previous", "--monitor", "cursor"], 0, 0)
                        }
                    }
                }

                MediaButton {
                    id: spotifyButton
                    styleKey: "spotify"
                    maximumLabelWidth: leftItems.mediaWidth < 12 ? 0 : leftItems.mediaWidth
                    readonly property TaskbarIndicator player: root.indicators.spotify ?? null

                    mediaText: player?.enabled ? player.label.slice(0, 80) : ""
                    tooltip: player?.tooltip ?? ""
                    onClicked: (x, y, button) => root.invoke(button === Qt.LeftButton
                        ? player?.spec.left : button === Qt.RightButton ? player?.spec.right : null, x, y)
                }

                MediaButton {
                    id: mediaButton
                    styleKey: "media"
                    maximumLabelWidth: leftItems.mediaWidth < 12 ? 0 : leftItems.mediaWidth
                    actionable: root.media?.canTogglePlaying === true || root.media?.canRaise === true
                    mediaText: root.icons.audio_player_enabled === false || !root.media?.trackTitle
                        ? "" : ((root.media.isPlaying ? "󰎇 " : "󰏥 ") + root.media.trackTitle).slice(0, 80)
                    tooltip: root.media?.trackArtist ?? ""
                    onClicked: (_, _, button) => {
                        if (button === Qt.LeftButton && root.media?.canTogglePlaying)
                            root.media.togglePlaying();
                        if (button === Qt.RightButton && root.media?.canRaise)
                            root.media.raise();
                    }
                }
            }

            StyledButton {
                anchors.verticalCenter: parent.verticalCenter
                styleKey: "window_title"
                readonly property real leftEdge: leftItems.x + leftItems.width
                readonly property real rightEdge: rightItems.x
                x: leftEdge + Math.round((Math.max(0, rightEdge - leftEdge) - width) / 2)
                height: bar.height
                leftPadding: 0
                actionable: false
                readonly property int availableWidth: Math.floor(rightEdge - leftEdge)
                maximumLabelWidth: Math.max(0, availableWidth - glyphWidth - contentSpacing)
                glyph: label && maximumLabelWidth > 0 ? "" : ""
                label: {
                    const title = String(Hyprland.activeToplevel?.title ?? "");
                    if (!title && !metrics.submap)
                        return "";
                    const submap = metrics.submap ? "[ " + metrics.submap.slice(0, 20) + " ] " : "";
                    return submap + title.slice(0, 50) + (title.length > 50 ? "…" : "");
                }
                foreground: root.presentation.windowForeground ?? root.presentation.foreground ?? "white"
            }

            property TaskbarButton tooltipTarget: null

            function updateTooltip(target: TaskbarButton, show: bool): void {
                if (show) {
                    tooltipPopup.visible = false;
                    tooltipTarget = target;
                    tooltipDelay.restart();
                } else if (tooltipTarget === target) {
                    tooltipDelay.stop();
                    tooltipPopup.visible = false;
                    tooltipTarget = null;
                }
            }

            Timer {
                id: tooltipDelay
                interval: 350
                onTriggered: {
                    if (bar.tooltipTarget?.visible && bar.tooltipTarget?.tooltip)
                        tooltipPopup.visible = true;
                }
            }

            PopupWindow {
                id: tooltipPopup
                color: "transparent"
                grabFocus: false
                visible: false
                anchor.item: bar.tooltipTarget
                anchor.edges: root.presentation.position === "bottom" ? Edges.Top : Edges.Bottom
                anchor.gravity: root.presentation.position === "bottom" ? Edges.Top : Edges.Bottom
                anchor.adjustment: PopupAdjustment.SlideX | PopupAdjustment.FlipY
                anchor.margins.top: 6
                anchor.margins.bottom: 6
                implicitWidth: Math.max(1, Math.min(320, bar.modelData.width - 12, tooltipText.implicitWidth + 16))
                implicitHeight: tooltipText.implicitHeight + 8

                Rectangle {
                    anchors.fill: parent
                    color: bar.backgroundColor
                    radius: 3

                    Text {
                        id: tooltipText
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        anchors.topMargin: 4
                        anchors.bottomMargin: 4
                        text: bar.tooltipTarget?.tooltip ?? ""
                        color: root.presentation.foreground ?? "white"
                        font.family: root.presentation.fontFamily ?? "IBM Plex Mono"
                        font.pixelSize: root.presentation.fontSize ?? 13
                        wrapMode: Text.Wrap
                        textFormat: Text.PlainText
                    }
                }
            }

            component StyledButton: TaskbarButton {
                id: button
                required property string styleKey
                readonly property var adjustment: root.iconAdjustments[styleKey] ?? ({})
                marginLeft: Math.max(0, adjustment.left ?? 0)
                marginRight: Math.max(0, adjustment.right ?? 0)
                marginTop: Math.max(0, adjustment.top ?? 0)
                marginBottom: Math.max(0, adjustment.bottom ?? 0)
                fontFamily: root.presentation.fontFamily ?? "IBM Plex Mono"
                fontSize: root.presentation.fontSize ?? 13
                foreground: root.presentation.foreground ?? "white"
                animated: root.presentation.animations !== false
                iconSize: Math.max(1, fontSize + root.iconSizeOffset + (adjustment.sizeOffset ?? 0))
                contentSpacing: root.iconSpacing
                onHoveredChanged: bar.updateTooltip(button, hovered && visible && tooltip !== "")
                onVisibleChanged: if (!visible) bar.updateTooltip(button, false)
                onTooltipChanged: if (!tooltip) bar.updateTooltip(button, false)
                onTooltipDismissed: bar.updateTooltip(button, false)
                Component.onDestruction: bar.updateTooltip(button, false)
            }

            component MediaButton: StyledButton {
                property string mediaText: ""
                readonly property string mediaIcon: root.leadingIcon(mediaText)
                glyph: maximumLabelWidth > 0 ? mediaIcon : ""
                label: mediaText.slice(mediaIcon.length).trim()
                anchors.verticalCenter: parent.verticalCenter
                height: bar.frameHeight
                frameInset: 5
                leftPadding: 16
                rightPadding: 11
                readonly property color mediaColor: bar.paletteColor(root.presentation.mediaBackground,
                    root.presentation.systemBackground ?? "#30343b")
                background: Qt.rgba(mediaColor.r, mediaColor.g, mediaColor.b,
                    mediaColor.a * (root.presentation.opacity ?? 1))
                borderColor: bar.paletteColor(root.presentation.mediaBorder, bar.groupBorder)
                borderWidth: bar.frameWidth
            }

            component Chip: TaskbarGroup {
                anchors.verticalCenter: parent.verticalCenter
                height: bar.frameHeight
                color: root.presentation.utilityBackground ?? "#303039"
                border.color: bar.groupBorder
                border.width: bar.frameWidth
            }

            component IndicatorButton: StyledButton {
                styleKey: providerId
                id: indicatorButton
                required property string providerId
                property bool revealed: true
                leftPadding: 0
                actionable: providerId === "power_profile" || !!(indicator?.spec.left || indicator?.spec.right
                    || indicator?.spec.up || indicator?.spec.down)
                readonly property TaskbarIndicator indicator: root.indicators[providerId] ?? null

                readonly property string statusLabel: indicator && indicator.enabled && revealed
                    ? root.indicatorLabel(indicator) : ""
                glyph: root.leadingIcon(statusLabel)
                label: glyph ? statusLabel.slice(glyph.length).trim() : statusLabel
                tooltip: indicator ? root.indicatorTooltip(indicator) : ""
                foreground: root.indicatorColor(providerId, indicator?.status ?? "")
                SequentialAnimation on opacity {
                    running: root.presentation.animations !== false && indicatorButton.indicator?.status === "recording"
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.4; duration: 600; easing.type: Easing.InOutQuad }
                    NumberAnimation { to: 1; duration: 600; easing.type: Easing.InOutQuad }
                    onStopped: indicatorButton.opacity = 1
                }
                fontFamily: root.presentation.fontFamily ?? "IBM Plex Mono"
                fontSize: root.presentation.fontSize ?? 13
                onClicked: (x, y, button) => {
                    if (button === Qt.LeftButton && providerId === "power_profile")
                        root.cyclePowerProfile();
                    else
                        bar.invoke(button === Qt.RightButton ? indicator?.spec.right
                            : button === Qt.LeftButton ? indicator?.spec.left : null, x, y);
                }
                onScrolled: direction => root.invoke(direction > 0 ? indicator?.spec.up : indicator?.spec.down, 0, 0)
            }

            Row {
                id: rightItems
                anchors.right: parent.right
                anchors.rightMargin: bar.frameWidth
                height: parent.height

                Row {
                    height: rightItems.height
                    spacing: root.iconSpacing
                    leftPadding: 9
                    rightPadding: 9
                    width: implicitWidth > leftPadding + rightPadding ? implicitWidth : 0

                    Repeater {
                        model: root.icons.tray_enabled === false ? null : SystemTray.items
                        delegate: StyledButton {
                            id: trayButton
                            styleKey: "tray"
                            required property SystemTrayItem modelData

                            height: rightItems.height
                            leftPadding: 0
                            iconPath: modelData.status === Status.Passive ? "" : modelData.icon
                            label: ""
                            tooltip: modelData.tooltipTitle || modelData.title
                            onClicked: (_, _, button) => {
                                if (button === Qt.RightButton || (button === Qt.LeftButton && modelData.onlyMenu)) {
                                    const point = trayButton.mapToItem(bar.contentItem, 0, height);
                                    modelData.display(bar, Math.round(point.x), Math.round(point.y));
                                } else if (button === Qt.LeftButton) {
                                    modelData?.activate();
                                } else if (button === Qt.MiddleButton) {
                                    modelData.secondaryActivate();
                                }
                            }
                            onScrolled: direction => modelData.scroll(direction * 120, false)
                        }
                    }
                }

                Chip {
                    id: utilityGroup
                    horizontalPadding: 11
                    animated: root.presentation.animations !== false && root.presentation.utilityExpanded !== true

                    HoverHandler {
                        onHoveredChanged: {
                            if (!hovered) {
                                revealDelay.stop();
                                bar.revealed = false;
                            }
                        }
                    }

                    StyledButton {
                        height: utilityGroup.buttonHeight
                        foreground: bar.highlight
                        label: ""
                        styleKey: "expander"
                        glyph: root.presentation.utilityExpanded === true ? "" : "‹"
                        HoverHandler {
                            onHoveredChanged: if (hovered) revealDelay.restart()
                        }
                    }

                    Repeater {
                        model: ["mode", "ai_agents", "notifications", "removable_devices", "recording",
                                "bluetooth", "clipboard", "audio_input", "audio_output", "keep_awake"]
                        delegate: IndicatorButton {
                            required property string modelData

                            providerId: modelData
                            leftPadding: Math.floor(root.iconSpacing / 2)
                            rightPadding: Math.ceil(root.iconSpacing / 2)
                            revealed: bar.expanded
                            height: utilityGroup.buttonHeight
                        }
                    }
                }

                Chip {
                    id: updateGroup
                    IndicatorButton { providerId: "update_status"; height: updateGroup.buttonHeight }
                }

                Chip {
                    id: systemGroup
                    horizontalPadding: 11
                    buttonSpacing: root.iconSpacing
                    color: root.presentation.systemBackground ?? "#30343b"
                    Repeater {
                        model: ["network", "power_profile", "keyboard_layout", "battery", "memory",
                                "cpu", "cpu_temperature", "gpu_temperature"]
                        delegate: IndicatorButton {
                            required property string modelData

                            providerId: modelData
                            height: systemGroup.buttonHeight
                        }
                    }
                }

                Chip {
                    id: focusGroup
                    IndicatorButton { providerId: "focus"; height: focusGroup.buttonHeight }
                }

                Chip {
                    id: dateGroup
                    horizontalPadding: 19
                    buttonSpacing: root.iconSpacing
                    IndicatorButton { providerId: "date"; height: dateGroup.buttonHeight }
                    StyledButton {
                        height: dateGroup.buttonHeight
                        styleKey: "clock"
                        glyph: label ? "󰅐" : ""
                        leftPadding: 0
                        label: root.icons.clock_enabled === false ? "" : Qt.formatTime(clock.date, root.presentation.timeFormat === "12h"
                            ? (root.presentation.timeSeconds ? "hh:mm:ss AP" : "hh:mm AP")
                            : (root.presentation.timeSeconds ? "HH:mm:ss" : "HH:mm"))
                        foreground: root.presentation.foreground ?? "white"
                        fontFamily: root.presentation.fontFamily ?? "IBM Plex Mono"
                        fontSize: root.presentation.fontSize ?? 13
                        onClicked: (x, y, button) => {
                            if (button === Qt.LeftButton)
                                bar.invoke(["argvus", "clock", "--toggle", "--x", "{x}", "--y", "{y}"], x, y);
                        }
                    }
                }

                StyledButton {
                    height: rightItems.height
                    label: ""
                    leftPadding: Math.floor(root.iconSpacing / 2)
                    rightPadding: Math.ceil(root.iconSpacing / 2)
                    styleKey: "power"
                    glyph: "󰐥"
                    foreground: root.presentation.powerForeground ?? bar.highlight
                    onClicked: (_, _, button) => {
                        if (button === Qt.LeftButton)
                            root.invoke(["argvus", "taskbar-actions", "--power-menu"], 0, 0);
                    }
                }

                StyledButton {
                    height: rightItems.height
                    label: ""
                    leftPadding: Math.floor(root.iconSpacing / 2)
                    rightPadding: Math.ceil(root.iconSpacing / 2)
                    styleKey: "sidebar"
                    glyph: sidebar.text().trim() === "open" ? "" : "󰍜"
                    onClicked: (_, _, button) => {
                        if (button === Qt.LeftButton)
                            root.invoke(["argvus", "taskbar-actions", "--sidebar-toggle"], 0, 0);
                    }
                }
            }
        }
    }
}
