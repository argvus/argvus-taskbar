import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Scope {
    id: root
    required property bool cpuEnabled
    required property bool memoryEnabled
    required property bool keyboardEnabled
    property string cpu: ""
    property string memory: ""
    property string keyboard: ""
    property string submap: ""
    property real previousTotal: 0
    property real previousIdle: 0

    Timer {
        interval: 5000
        repeat: true
        running: root.cpuEnabled || root.memoryEnabled
        triggeredOnStart: true
        onTriggered: {
            cpuReader.running = root.cpuEnabled;
            memoryReader.running = root.memoryEnabled;
        }
    }

    Process {
        id: cpuReader
        command: ["head", "-n", "1", "/proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                const fields = text.trim().split(/\s+/).slice(1, 9).map(Number);
                if (fields.length !== 8 || fields.some(value => !Number.isFinite(value)))
                    return;
                const total = fields.reduce((sum, value) => sum + value, 0);
                const idle = fields[3] + fields[4];
                const elapsed = total - root.previousTotal;
                if (root.previousTotal && elapsed > 0)
                    root.cpu = Math.round(100 * (1 - (idle - root.previousIdle) / elapsed)) + "%";
                root.previousIdle = idle;
                root.previousTotal = total;
            }
        }
    }

    Process {
        id: memoryReader
        command: ["cat", "/proc/meminfo"]
        stdout: StdioCollector {
            onStreamFinished: {
                const total = Number(text.match(/^MemTotal:\s+(\d+)/m)?.[1]);
                const available = Number(text.match(/^MemAvailable:\s+(\d+)/m)?.[1]);
                if (total > 0 && Number.isFinite(available))
                    root.memory = Math.round(100 * (1 - available / total)) + "%";
            }
        }
    }

    Process {
        id: keyboardReader
        running: root.keyboardEnabled
        command: ["hyprctl", "devices", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const keyboards = JSON.parse(text).keyboards ?? [];
                    const keyboard = keyboards.find(device => device.main) ?? keyboards[0];
                    const layouts = (keyboard?.layout ?? "").split(",");
                    root.keyboard = layouts[keyboard?.active_layout_index ?? 0] || keyboard?.active_keymap || "";
                } catch (_) {
                    root.keyboard = "";
                }
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent): void {
            if (event.name === "submap")
                root.submap = event.data === "reset" ? "" : event.data;
            if (event.name === "activelayout" && root.keyboardEnabled)
                keyboardReader.running = true;
        }
    }
}
