pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    readonly property string runtimeDirectory: Quickshell.env("XDG_RUNTIME_DIR") + "/argvus/bars"
    readonly property string configurationDirectory: (Quickshell.env("ARGVUS_CONFIG_HOME")
        || Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.config") + "/argvus/config"
    property var presentation: ({})
    property string appliedPresentation: ""
    signal telemetryRefreshRequested()

    function readSettings(contents: string): void {
        if (!contents)
            return;
        try {
            const snapshot = JSON.parse(contents);
            if (snapshot && typeof snapshot === "object" && !Array.isArray(snapshot)) {
                presentation = snapshot;
                appliedPresentation = contents.trim();
            }
        } catch (error) {
            console.warn("Cannot read ARGVUS bars settings:", error);
        }
    }

    Timer {
        id: debounce
        interval: 150
        onTriggered: {
            if (projection.running)
                restart();
            else
                projection.running = true;
        }
    }

    Process {
        id: projection
        command: [(Quickshell.env("ARGVUS_SYSTEM_CONFIG") || "/usr/share/argvus") + "/taskbar/sh/bars-presentation.sh"]
    }

    Instantiator {
        model: ["taskbar", "layout", "effects", "fonts", "appearance"]
        delegate: FileView {
            required property string modelData
            path: root.configurationDirectory + "/" + modelData + ".json"
            watchChanges: true
            printErrors: false
            onFileChanged: {
                reload();
                debounce.restart();
            }
        }
    }

    FileView {
        path: root.runtimeDirectory + "/presentation.json"
        watchChanges: true
        printErrors: false
        onFileChanged: reload()
        onTextChanged: root.readSettings(text())
    }

    FileView {
        id: telemetryActivation
        path: root.runtimeDirectory + "/widget-telemetry.active"
        watchChanges: true
        printErrors: false
        onFileChanged: reload()
    }

    LazyLoader {
        id: telemetry
        active: telemetryActivation.text() === "enabled\n"

        WidgetTelemetry {
            id: panel
            settings: root.presentation.telemetry || {}
            Connections {
                target: root
                function onTelemetryRefreshRequested(): void { panel.refreshLayout(); }
            }
        }
    }

    FileView {
        id: floatingActivation
        path: root.runtimeDirectory + "/window-bar.active"
        watchChanges: true
        printErrors: false
        onFileChanged: reload()
    }

    LazyLoader {
        id: floating
        active: floatingActivation.text() === "enabled\n"
        WindowBar { presentation: root.presentation.taskbar || {} }
    }

    FileView {
        id: taskbarActivation
        path: root.runtimeDirectory + "/taskbar.active"
        watchChanges: true
        printErrors: false
        onFileChanged: reload()
    }

    LazyLoader {
        id: taskbar
        active: taskbarActivation.text() === "enabled\n"
        Taskbar {
            presentation: root.presentation.taskbar || {}
            sidebarStatePath: (Quickshell.env("XDG_CACHE_HOME") || Quickshell.env("HOME") + "/.cache")
                              + "/argvus/waybar/control-panel-state"
        }
    }

    IpcHandler {
        target: "bars"

        function active(surface: string): bool {
            switch (surface) {
            case "taskbar": return taskbar.item !== null;
            case "widget-telemetry": return telemetry.item !== null;
            case "window-bar": return floating.item !== null;
            default: return false;
            }
        }

        function hasPresentation(contents: string): bool {
            return root.appliedPresentation === contents.trim();
        }
    }

    IpcHandler {
        target: "taskbar"

        function toggle(): void {
            const bar = taskbar.item as Taskbar;
            if (bar)
                bar.displayed = !bar.displayed;
        }
        function refreshUpdates(): void {
            const bar = taskbar.item as Taskbar;
            if (bar)
                bar.refreshUpdates();
        }
    }

    IpcHandler {
        target: "telemetry"

        function refresh(): void {
            root.telemetryRefreshRequested();
        }
    }
}
