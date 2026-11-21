import QtQuick

Item {
    id: root

    default property alias buttons: row.data
    property color color: "transparent"
    property alias border: frame.border
    property int leadingSpace: 5
    property int horizontalPadding: 10
    property int buttonSpacing: 0
    property bool animated: false
    readonly property int buttonHeight: row.height

    implicitWidth: row.implicitWidth + 2 * horizontalPadding + leadingSpace
    width: row.implicitWidth > 0 ? implicitWidth : 0
    clip: animated

    Behavior on width {
        enabled: root.animated
        NumberAnimation { duration: 240; easing.type: Easing.OutCubic }
    }

    Rectangle {
        id: frame
        anchors.fill: parent
        anchors.leftMargin: root.leadingSpace
        color: root.color
        visible: root.width > root.leadingSpace
    }

    Row {
        id: row
        x: root.horizontalPadding + root.leadingSpace
        height: root.height
        spacing: root.buttonSpacing
    }
}
