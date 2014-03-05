import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica 1.0

Page {
    id: page

    property alias _refreshMenuAction: refreshMenuAction
    property alias _aboutMenuAction: aboutMenuAction


    function load() {
        var url = 'http://rec0de.net/upnext/';

        var xhr = new XMLHttpRequest();
        xhr.timeout = 10000;

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                console.log('status', xhr.status, xhr.statusText)
                console.log('response', xhr.responseText)
                if(xhr.status >= 200 && xhr.status < 300) {


                    //Escaping content fetched from web to prevent script injections
                    var patt1 = /<br>/g;
                    var patt2 = /(<|>|\{|\}|\[|\]|\\)/g;
                    var patt3 = /1br1/g;
                    var text = xhr.responseText.replace(patt1,"1br1");
                    text = text.replace(patt1, '');
                    text = text.replace(patt3, '<br>');

                    text = text.replace('&', 'und'); // Fixes a weird bug...

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


    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                id: aboutMenuAction
                text: "About"
                onClicked: {
                    console.log("aboutMenuAction clicked")
                    pageStack.push(Qt.resolvedUrl("about.qml"))
                }

            }

            MenuItem {
                id: refreshMenuAction
                text: "Refresh"
                onClicked: {
                    console.log("refreshMenuAction clicked")
                    content.text = load()
                }

            }

        }

        contentHeight: childrenRect.height


        Column {
            anchors.fill: parent
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingLarge
            PageHeader {
                title: "UpNext"
            }

            //TODO: Make this look less horrible
            Label {
                id: content
                text: load()
            }
        }
    }

}
