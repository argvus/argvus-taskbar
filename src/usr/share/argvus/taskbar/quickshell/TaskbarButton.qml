import QtQuick

Item {
    id: root
    required property string label
    property string glyph: ""
    readonly property int glyphSize: iconSize
    property int glyphWidth: glyphSize
    property string tooltip: ""
    property string iconPath: ""
    property int contentSpacing: 3
    property int iconSize: 22
    property var appIcons: []
    property bool selected: false
    property bool actionable: true
    property bool animated: true
    property bool workspace: false
    property bool bold: false
    property color background: "transparent"
    property color borderColor: "transparent"
    property int borderWidth: 0
    property int frameInset: 0
    property int leftPadding: 8
    property int rightPadding: leftPadding
    property int marginLeft: 0
    property int marginRight: 0
    property int marginTop: 0
    property int marginBottom: 0
    property int minimumWidth: 0
    property int labelVerticalOffset: 0
    property int maximumLabelWidth: -1
    readonly property bool hovered: pointer.containsMouse
    signal tooltipDismissed()
    property color foreground: "white"
    property color workspaceText: "black"
    readonly property bool workspaceHighlighted: workspace && (selected || hovered)
    property string fontFamily: "IBM Plex Mono"
    property int fontSize: 13
    signal clicked(real x, real y, int button)
    signal scrolled(int direction)

    readonly property int contentCount: Number(label !== "" && maximumLabelWidth !== 0) + Number(iconPath !== "") + Number(glyph !== "") + appIcons.length

    implicitWidth: contentCount > 0
        ? marginLeft + marginRight + Math.max(minimumWidth, caption.width + glyphItem.width + (iconPath !== "" ? iconSize : 0) + appIcons.length * iconSize
            + (contentCount - 1) * contents.spacing + leftPadding + rightPadding)
        : 0
    visible: contentCount > 0
    width: implicitWidth

    Item {
        id: buttonBody
        x: root.marginLeft
        y: root.marginTop
        width: Math.max(0, root.width - root.marginLeft - root.marginRight)
        height: Math.max(0, root.height - root.marginTop - root.marginBottom)
    }

    Rectangle {
        parent: buttonBody
        anchors.fill: parent
        anchors.leftMargin: root.workspace ? 1 : root.frameInset
        anchors.rightMargin: root.workspace ? 1 : 0
        color: root.workspaceHighlighted ? root.foreground : root.background
        opacity: root.workspaceHighlighted ? 0.85 : 1
        border.width: root.borderWidth
        border.color: root.borderColor
    }

    TextMetrics {
        id: captionMetrics
        font: caption.font
        text: root.label
    }

    Row {
        id: contents
        z: 1
        parent: buttonBody
        anchors.left: parent.left
        anchors.leftMargin: Math.round((parent.width - width + root.leftPadding - root.rightPadding) / 2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.labelVerticalOffset
        spacing: root.contentSpacing
        opacity: root.actionable && root.hovered && !root.workspace ? 0.75 : 1

        Behavior on opacity {
            enabled: root.animated
            NumberAnimation { duration: 160 }
        }

        Image {
            source: root.iconPath
            visible: root.iconPath !== ""
            width: root.iconPath !== "" ? root.iconSize : 0
            height: root.iconSize
            sourceSize.width: root.iconSize
            sourceSize.height: root.iconSize
        }

        Text {
            id: glyphItem
            visible: root.glyph !== ""
            width: root.glyph !== "" ? root.glyphWidth : 0
            anchors.verticalCenter: contents.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            text: root.glyph
            textFormat: Text.PlainText
            color: root.workspaceHighlighted ? root.workspaceText : root.foreground
            font.family: "Symbols Nerd Font Mono"
            font.pixelSize: root.glyphSize
        }

        Text {
            id: caption
            visible: root.label !== "" && root.maximumLabelWidth !== 0
            anchors.verticalCenter: parent.verticalCenter
            width: root.label === "" ? 0 : root.maximumLabelWidth < 0 ? Math.ceil(captionMetrics.advanceWidth)
                : Math.min(root.maximumLabelWidth, Math.ceil(captionMetrics.advanceWidth))
            elide: Text.ElideRight
            text: root.label
            textFormat: Text.PlainText
            color: root.workspaceHighlighted ? root.workspaceText : root.foreground
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: root.bold
        }

        Repeater {
            model: root.appIcons
            Image {
                required property string modelData

                source: modelData
                width: root.iconSize
                height: root.iconSize
                sourceSize.width: root.iconSize
                sourceSize.height: root.iconSize
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        id: pointer
        z: 2
        parent: buttonBody
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: root.actionable ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: root.actionable ? Qt.LeftButton | Qt.RightButton | Qt.MiddleButton : Qt.NoButton
        onPressed: root.tooltipDismissed()
        onClicked: function (event: MouseEvent): void {
            const point = mapToItem(null, event.x, event.y);
            root.clicked(point.x, point.y, event.button);
        }
        onWheel: function (event: WheelEvent): void {
            root.tooltipDismissed();
            if (event.angleDelta.y)
                root.scrolled(event.angleDelta.y > 0 ? 1 : -1);
        }
    }

}
