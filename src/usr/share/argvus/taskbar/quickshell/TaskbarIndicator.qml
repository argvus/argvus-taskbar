import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root
    required property var spec
    property bool enabled: true
    property string label: spec.label ?? ""
    property string tooltip: ""
    property string status: ""

    function consume(line: string): void {
        if (spec.tooltipOnly) {
            tooltip = line.trim();
            return;
        }
        try {
            const value = spec.json ? JSON.parse(line) : { text: line.trim() };
            const text = typeof value.text === "string" ? value.text.replace(/<\/?span(?: [^>]*)?>/g, "").trim() : "";
            label = text ? (spec.prefix ?? "") + text + (spec.suffix ?? "") : "";
            tooltip = typeof value.tooltip === "string" ? value.tooltip : "";
            status = typeof value.class === "string" ? value.class : "";
        } catch (error) {
            console.warn("Invalid taskbar output for", spec.id, error);
        }
    }

    function refresh(): void {
        if (enabled && spec.command && !provider.running)
            provider.running = true;
    }

    onEnabledChanged: {
        if (enabled)
            refresh();
        else
            provider.running = false;
    }

    Component.onCompleted: refresh()

    Timer {
        interval: (root.spec.interval ?? 0) * 1000
        repeat: true
        running: root.enabled && interval > 0
        onTriggered: root.refresh()
    }

    Timer {
        id: reconnect
        interval: 1500
        onTriggered: root.refresh()
    }

    Process {
        id: provider
        command: root.spec.command ?? []
        stdout: SplitParser { onRead: line => root.consume(line) }
        onExited: function (exitCode: int): void {
            if (exitCode !== 0)
                root.consume(root.spec.json ? "{}" : "");
            if (root.enabled && root.spec.stream)
                reconnect.restart();
        }
    }
}
