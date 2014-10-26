import QtQuick 2.0
import Sailfish.Silica 1.0
import "../data.js" as DB

CoverBackground {

    Image {
           source: "../cover.png"
           opacity: 0.1
           width: parent.width
           height: sourceSize.height * width / sourceSize.width
       }

    Component.onCompleted: {
        // Initialize the database
        DB.initialize();
    }

    ListModel {
        id: programlist

        ListElement {
            name: "ARD"
            program: "..."
            active: true
        }
        ListElement {
            name: "ZDF"
            program: "..."
            active: true
        }
        ListElement {
            name: "3sat"
            program: "..."
            active: true
        }
        ListElement {
            name: "Kabel1"
            program: "..."
            active: true
        }
        ListElement {
            name: "RTL"
            program: "..."
            active: true
        }
        ListElement {
            name: "Pro7"
            program: "..."
            active: true
        }
        ListElement {
            name: "Sat1"
            program: "..."
            active: true
        }
        ListElement {
            name: "Vox"
            program: "..."
            active: true
        }
        ListElement {
            name: "Arte"
            program: "..."
            active: true
        }
        ListElement {
            name: "Phoenix"
            program: "..."
            active: true
        }
        ListElement {
            name: "WDR"
            program: "..."
            active: true
        }
        ListElement {
            name: "SRF1"
            program: "..."
            active: true
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

                    text = text.replace('& ', 'und'); // Fixes a weird bug...
                    text = text.replace('&nbsp;', ' ');
                    text = text.replace('&hellip;', '...');

                    var programarray = text.split('|')

                    for (var i = 0; i < 12; i++) {

                        if(programarray[i] == ' '){
                            programarray[i] = 'Error :('
                        }

                        //Experimental Channel opt-out
                        if(DB.getCover(i+1) == 0){
                            programlist.set(i, {"active": false})
                        }
                        else {
                           programlist.set(i, {"program": programarray[i]})
                           programlist.set(i, {"active": true})
                        }
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
                    visible: active
                }

                Label {
                    font.pixelSize: Theme.fontSizeExtraSmall - 2
                    width: parent.width
                    text: program
                    truncationMode: TruncationMode.Fade
                    visible: active
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

