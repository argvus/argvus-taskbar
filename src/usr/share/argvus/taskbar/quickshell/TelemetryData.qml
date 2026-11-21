import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root

    required property string block
    required property int interval
    property string heading: ""
    property string content: ""

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: headerProcess.running = true
    }

    Timer {
        interval: root.interval * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: contentProcess.running = true
    }

    Process {
        id: headerProcess
        command: ["argvus", "widget-telemetry", "block", "header", root.block]
        stdout: StdioCollector {
            onStreamFinished: root.heading = text.trim()
        }
    }

    Process {
        id: contentProcess
        command: ["argvus", "widget-telemetry", "block", root.block]
        stdout: StdioCollector {
            onStreamFinished: {
                if (root.block === "keys") {
                    root.content = text.trim();
                    return;
                }
                try {
                    const value = JSON.parse(text).text;
                    root.content = typeof value === "string" ? value : "";
                } catch (_) {
                    // A collector can exit before writing a complete JSON record.
                }
            }
        }
    }

}
