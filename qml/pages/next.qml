import QtQuick 2.0
import Sailfish.Silica 1.0
import "../data.js" as DB

Page {
    id: page

    property alias _refreshMenuAction: refreshMenuAction
    property alias _aboutMenuAction: aboutMenuAction


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
        var url = 'https://cdown.pf-control.de/upnext/new/next.html'; // alias domain for rec0de.net with valid SSL cert
        progress.visible = true;
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

                    text = text.replace('& ', 'und '); // Fixes a weird bug...
                    text = text.replace('&#039;', '\'');

                    var programarray = text.split('|')

                    progress.visible = false;

                    for (var i = 0; i < 12; i++) {

                        if(programarray[i] == ' '){
                            programarray[i] = 'No data available (yet)'
                        }

                        //Experimental Channel opt-out
                        if(DB.getText(i+1) == 0){
                            programlist.set(i, {"active": false})
                        }
                        else {
                           programlist.set(i, {"program": programarray[i]})
                           programlist.set(i, {"active": true})
                        }
                    }

                }
                else {
                    progress.visible = false;
                    message.visible = true;
                    message.text = 'Hmm.. Something went wrong.<br>';
                }
            }
        }

        xhr.ontimeout = function() {
            progress.visible = false;
            message.visible = true;
            message.text = 'Error: Request timed out.<br>';
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
                text: "About & Settings"
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
                    load()
                }

            }

        }


        Column {
            anchors.fill: parent
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingSmall
            width: parent.width
            height: parent.height

            PageHeader {
                title: "Next"
            }

            ProgressBar  {
                id: progress
                visible: false
                width: parent.width
                indeterminate: true
            }

            Label {
                id: message
                visible: false;
                wrapMode: Text.WordWrap
                text: load() // Some sort of workaround for loading on startup
            }

            ListView {
                model: programlist
                width: parent.width
                height: parent.height - 100
                boundsBehavior: Flickable.StopAtBounds
                delegate: Column {
                    width: parent.width

                    VerticalScrollDecorator{}

                    Label {
                        width: parent.width
                        text: name
                        visible: active
                    }

                    Label {
                        width: parent.width
                        text: program
                        truncationMode: TruncationMode.Fade
                        visible: active
                    }
                    // Spacer
                    Label {
                        width: parent.width
                        text: ''
                        visible: active
                    }


                }
            }


        }
    }

}
