import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    function load() {
        var url = 'http://rec0de.net/upnext/cover/';

        content.font.pixelSize = Theme.fontSizeExtraSmall;

        var xhr = new XMLHttpRequest();
        xhr.timeout = 10000;

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                console.log('status', xhr.status, xhr.statusText)
                console.log('response', xhr.responseText)
                if(xhr.status >= 200 && xhr.status < 300) {
                    var patt1 = /<br>/g;
                    var patt2 = /(<|>|\{|\}|\[|\]|\\)/g;
                    var patt3 = /1br1/g;
                    var text = xhr.responseText.replace(patt1,"1br1");
                    text = text.replace(patt1, '');
                    text = text.replace(patt3, '<br>');
                    content.text = text;
                } else {
                    content.text = 'Hmm.. Something went wrong.';
                }
            }
        }

        xhr.ontimeout = function() {
            content.text = 'Error: Request timed out.';
        }

        xhr.open('GET', url, true);
        xhr.setRequestHeader("User-Agent", "Mozilla/5.0 (compatible; UpNext app for SailfishOS)");
        xhr.send();
    }

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingSmall
        spacing: Theme.paddingSmall

        Label {
            id: content
            text: "UpNext"
            font.pixelSize: Theme.fontSizeLarge
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                load()
            }
        }
    }
}

