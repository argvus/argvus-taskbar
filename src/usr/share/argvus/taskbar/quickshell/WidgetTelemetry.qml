pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: root

    required property var settings
    property var visibleBlocks: []
    readonly property var refreshSeconds: ({
        system: 3600,
        cpu_gpu: 10,
        memory: 5,
        storage: 30,
        processes: 1,
        network: 10,
        dev_dashboard: 10,
        keys: 3600
    })

    readonly property color panelBackground: settings.background ?? "#333942"
    readonly property color accent: settings.accent ?? "#a8c7ff"
    readonly property color borderColor: borderTint(0.15)
    readonly property color headerBorderColor: borderTint(0.20)

    function borderTint(alpha: real): color {
        if (settings.transparencyEnabled !== false)
            return Qt.rgba(accent.r, accent.g, accent.b, alpha);
        return Qt.rgba(panelBackground.r + (accent.r - panelBackground.r) * alpha,
                       panelBackground.g + (accent.g - panelBackground.g) * alpha,
                       panelBackground.b + (accent.b - panelBackground.b) * alpha, 1);
    }

    function refreshLayout(): void {
        layoutRefresh.restart();
    }

    Component.onCompleted: refreshLayout()

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent): void {
            if (["focusedmon", "monitoradded", "monitorremoved", "configreloaded"].includes(event.name))
                root.refreshLayout();
        }
    }

    Timer {
        id: layoutRefresh
        interval: 80
        onTriggered: {
            if (layout.running)
                restart();
            else
                layout.running = true;
        }
    }

    Process {
        id: layout
        command: ["argvus", "widget-telemetry", "toggle", "visible"]
        stdout: StdioCollector {
            onStreamFinished: {
                const blocks = text.trim().split(/\s+/);
                root.visibleBlocks = blocks.filter(block =>
                    Object.prototype.hasOwnProperty.call(root.refreshSeconds, block));
            }
        }
    }

    Process {
        id: scroll
        onExited: root.refreshLayout()
    }

    Instantiator {
        id: providers
        model: root.visibleBlocks

        delegate: TelemetryData {
            required property string modelData

            block: modelData
            interval: root.refreshSeconds[block]
        }
    }

    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            required property ShellScreen modelData
            screen: modelData
            anchors { top: true; bottom: true; left: true }
            WlrLayershell.namespace: "argvus-widget-telemetry"
            WlrLayershell.margins {
                top: root.settings.marginTop ?? 0
                left: root.settings.marginLeft ?? 0
                bottom: root.settings.marginBottom ?? 0
            }
            WlrLayershell.layer: WlrLayer.Bottom
            exclusiveZone: 0
            implicitWidth: root.settings.width ?? 380
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: Qt.rgba(root.panelBackground.r, root.panelBackground.g, root.panelBackground.b, root.settings.opacity ?? 0.35)
                border.width: 1
                border.color: root.borderColor

                WheelHandler {
                    target: null
                    onWheel: function (event: WheelEvent): void {
                        if (!event.angleDelta.y || scroll.running)
                            return;
                        scroll.command = ["argvus", "widget-telemetry", "toggle", "scroll",
                                          event.angleDelta.y > 0 ? "up" : "down"];
                        scroll.running = true;
                    }
                }

                Column {
                    anchors.fill: parent
                    anchors.topMargin: 8
                    anchors.bottomMargin: 8
                    clip: true

                    Repeater {
                        model: providers.count

                        TelemetryBlock {
                            required property int index

                            width: parent.width
                            dataSource: providers.objectAt(index) as TelemetryData
                            settings: root.settings
                            headerBorder: root.headerBorderColor
                        }
                    }
                }
            }
        }
    }
}
