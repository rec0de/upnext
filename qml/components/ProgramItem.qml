import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    property alias senderName : senderLabel.text
    property alias programText : programLabel.text
    anchors {
        left: parent.left
        leftMargin: Theme.paddingLarge
        right: parent.right
        rightMargin: Theme.paddingLarge
    }

    height: Theme.itemSizeMedium

    Column {
        width: parent.width

        Label {
            id: senderLabel
            width: parent.width
            visible: active
            color: Theme.highlightColor
        }

        Label {
            id: programLabel
            width: parent.width
            truncationMode: TruncationMode.Fade
            visible: active
        }
    }
}
