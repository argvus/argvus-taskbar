import QtQuick

Column {
    id: root

    required property TelemetryData dataSource
    required property var settings
    required property color headerBorder
    readonly property string family: settings.fontFamily ?? "IBM Plex Mono"
    readonly property int pixelSize: settings.fontSize ?? 14

    visible: dataSource.heading !== "" || dataSource.content !== ""

    Rectangle {
        width: parent.width
        height: 1
        color: root.headerBorder
    }

    Text {
        width: parent.width
        leftPadding: 16
        rightPadding: 16
        topPadding: 6
        bottomPadding: 2
        textFormat: Text.PlainText
        text: root.dataSource.heading
        color: root.settings.accent ?? "#a8c7ff"
        font.family: root.family
        font.pixelSize: root.pixelSize
        font.bold: true
    }

    Text {
        width: parent.width
        leftPadding: 16
        rightPadding: 16
        topPadding: 1
        bottomPadding: 7
        textFormat: Text.PlainText
        text: root.dataSource.content.replace(/<\/?span>/g, "")
        color: root.settings.foreground ?? "#eeeeee"
        font.family: root.family
        font.pixelSize: root.pixelSize
        elide: Text.ElideRight
    }
}
