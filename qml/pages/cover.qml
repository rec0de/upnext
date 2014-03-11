import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Image {
           source: "../cover.png"
           opacity: 0.1
           width: parent.width
           height: sourceSize.height * width / sourceSize.width
       }

    ListModel {
        id: programlist

        ListElement {
            name: "ARD"
            program: "..."
        }
        ListElement {
            name: "ZDF"
            program: "..."
        }
        ListElement {
            name: "3sat"
            program: "..."
        }
        ListElement {
            name: "Kabel1"
            program: "..."
        }
        ListElement {
            name: "RTL"
            program: "..."
        }
        ListElement {
            name: "Pro7"
            program: "..."
        }
    }


    function load() {
        var url = 'https://cdown.pf-control.de/upnext/new/'; // alias domain for rec0de.net with valid SSL cert
        message.visible = false;

        var xhr = new XMLHttpRequest();
        xhr.timeout = 1000;

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                console.log('status', xhr.status, xhr.statusText)
                console.log('response', xhr.responseText)
                if(xhr.status >= 200 && xhr.status < 300) {

                    var text = xhr.responseText;

                    //Escaping content fetched from web to prevent script injections
                    var patt1 = /(<|>|\{|\}|\[|\]|\\)/g;
                    text = text.replace(patt1, '');

                    text = text.replace('&', 'und'); // Fixes a weird bug...

                    var programarray = text.split('|')

                    for (var i = 0; i < 6; i++) {

                        if(programarray[i] == ' '){
                            programarray[i] = 'Error :('
                        }

                    programlist.set(i, {"program": programarray[i]})
                    }

                }
                else {
                    message.visible = true;
                    message.text = 'Hmm.. Something went wrong.<br>';
                }
            }
        }

        xhr.ontimeout = function() {
            message.visible = true;
            message.text = 'Error: Request timed out.<br>';
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
            id: message
            wrapMode: Text.WordWrap
            visible: false;
            text: load() // Some sort of workaround for loading on startup
        }

        ListView {
            model: programlist
            width: parent.width
            height: parent.height
            delegate: Column {
                width: parent.width

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: name
                }

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall
                    width: parent.width
                    text: program
                    truncationMode: TruncationMode.Fade
                }

            }
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

