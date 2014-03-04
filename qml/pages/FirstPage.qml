import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica 1.0

Page {
    id: page

    // Exposing properties for testing. In real app you might like to hide it behind a single interface
    // e.g. via "property variant internals" and then put a QtObject with the individual properties to it
    // @TODO: implement exposing via single internals property
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


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
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

        // Tell SilicaFlickable the height of its content.
        contentHeight: childrenRect.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            anchors.fill: parent
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingLarge
            PageHeader {
                title: "UpNext"
            }

            Label {
                id: content
                text: load()
            }
        }
    }

}
