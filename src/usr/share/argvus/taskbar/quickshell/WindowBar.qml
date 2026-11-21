pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: root
    required property var presentation
    property var snapshot: ({})
    readonly property bool shown: snapshot.floating === true || snapshot.recovering === true

    Timer {
        id: reconnect
        interval: 1000
        onTriggered: watch.running = true
    }

    Process {
        id: watch
        running: true
        command: ["argvus", "windows", "watch", "--json"]
        stdout: SplitParser {
            onRead: function (line: string): void {
                try {
                    const next = JSON.parse(line);
                    if (!next.error)
                        root.snapshot = next;
                } catch (error) {
                    console.warn("Invalid ARGVUS window snapshot:", error);
                }
            }
        }
        onExited: {
            root.snapshot = {};
            reconnect.restart();
        }
    }

    function action(name: string, address: string): void {
        Quickshell.execDetached(["argvus", "windows", name, address]);
    }

    Timer {
        interval: 1000
        running: root.shown
        repeat: true
        triggeredOnStart: true
        onTriggered: Quickshell.execDetached(["argvus", "windows", "ready"])
    }

    Variants {
        model: root.shown ? Quickshell.screens : []
        delegate: PanelWindow {
            id: panel
            required property ShellScreen modelData

            screen: modelData
            anchors {
                left: true
                right: true
                top: root.snapshot.position === "bottom"
                bottom: root.snapshot.position !== "bottom"
            }
            implicitHeight: root.presentation.height ?? 28
            readonly property color backgroundColor: root.presentation.background ?? "#252830"
            color: Qt.rgba(backgroundColor.r, backgroundColor.g, backgroundColor.b, root.presentation.opacity ?? 0.85)
            WlrLayershell.namespace: "argvus-window-bar"
            WlrLayershell.margins {
                top: root.presentation.marginBottom ?? 0
                right: root.presentation.marginRight ?? 0
                bottom: root.presentation.marginTop ?? 0
                left: root.presentation.marginLeft ?? 0
            }

            ListModel { id: windowModel }

            function updateWindows(): void {
                const windows = (root.snapshot.windows ?? []).filter(window => window.output === modelData.name);
                for (let index = 0; index < windows.length; ++index) {
                    const window = windows[index];
                    const item = {
                        windowAddress: window.address,
                        windowTitle: window.title,
                        windowIcon: window.app_id,
                        windowWorkspace: window.workspace,
                        windowActive: window.active,
                        windowMinimized: window.minimized
                    };
                    let found = index;
                    while (found < windowModel.count && windowModel.get(found).windowAddress !== item.windowAddress)
                        ++found;
                    if (found === windowModel.count) {
                        windowModel.insert(index, item);
                    } else {
                        if (found !== index)
                            windowModel.move(found, index, 1);
                        windowModel.set(index, item);
                    }
                }
                if (windowModel.count > windows.length)
                    windowModel.remove(windows.length, windowModel.count - windows.length);
            }

            Component.onCompleted: updateWindows()

            Connections {
                target: root
                function onSnapshotChanged(): void { panel.updateWindows(); }
            }

            Row {
                id: row
                anchors.fill: parent
                Repeater {
                    id: buttons
                    model: windowModel
                    delegate: Button {
                        id: windowButton
                        required property string windowAddress
                        required property string windowTitle
                        required property string windowIcon
                        required property string windowWorkspace
                        required property bool windowActive
                        required property bool windowMinimized
                        width: row.width / Math.max(1, buttons.count)
                        height: row.height
                        text: windowTitle
                        icon.source: Quickshell.iconPath(windowIcon, "application-x-executable")
                        icon.width: 16
                        icon.height: 16
                        icon.color: "transparent"
                        font.family: root.presentation.fontFamily ?? "IBM Plex Mono"
                        font.pixelSize: root.presentation.fontSize ?? 13
                        opacity: windowMinimized ? 0.65 : 1
                        highlighted: windowActive
                        ToolTip.visible: hovered
                        ToolTip.text: windowTitle + "\n" + windowWorkspace
                        onClicked: root.action("toggle", windowAddress)

                        background: Rectangle {
                            readonly property color accent: root.presentation.accent ?? "#a8c7ff"
                            color: windowButton.highlighted || windowButton.hovered
                                ? Qt.rgba(accent.r, accent.g, accent.b, 0.35)
                                : (root.presentation.utilityBackground ?? "#303039")
                            radius: root.presentation.radius ?? 0
                            border.width: root.presentation.borderWidth ?? 1
                            border.color: Qt.rgba(accent.r, accent.g, accent.b, 0.25)
                        }

                        TapHandler {
                            acceptedButtons: Qt.RightButton
                            onTapped: menu.popup()
                        }

                        Menu {
                            id: menu
                            Repeater {
                                model: ["restore", "minimize", "maximize", "close"]
                                delegate: MenuItem {
                                    required property string modelData
                                    text: root.snapshot.labels?.[modelData] ?? modelData
                                    onTriggered: root.action(modelData, windowButton.windowAddress)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
