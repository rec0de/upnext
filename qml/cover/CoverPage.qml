import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    function setcover(url) {
            var doc = new XMLHttpRequest();
            doc.onreadystatechange = function() {
                if (doc.readyState == XMLHttpRequest.DONE) {
                    content.text = doc.responseText;
                }
            }
            doc.open("get", url);
            doc.setRequestHeader("Content-Encoding", "UTF-8");
            doc.send();
        }

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingSmall
        spacing: Theme.paddingSmall

        Label {
            id: content
            text: "UpNext"
            font.pixelSize: Theme.fontSizeExtraSmall
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                setcover('http://rec0de.net/upnext/cover.html')
            }
        }
    }
}


