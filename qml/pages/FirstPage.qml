import QtQuick 2.0
import Sailfish.Silica 1.0
import "../data.js" as DB

Page {
    id: page

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
        progress.visible = true;
        message.enabled = false;

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

                    text = text.replace('& ', 'und '); // Fixes a weird bug... //Causes more bugs... TODO
                    text = text.replace('&#039;', '\'');

                    var programarray = text.split('|')

                    progress.visible = false;
                    listView.visible = true;


                    for (var i = 0; i < 12; i++) {

                        if(programarray[i] == ' '){
                            programarray[i] = 'Error :('
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
                    listView.visible = false;
                    progress.visible = false;
                    message.enabled = true;
                    message.text = 'Hmm.. Something went wrong.<br>';
                }
            }
        }

        xhr.ontimeout = function() {
            listView.visible = false;
            progress.visible = false;
            message.enabled = true;
            message.text = 'Error: Request timed out.<br>';
        }

        xhr.open('GET', url, true);
        xhr.setRequestHeader("User-Agent", "Mozilla/5.0 (compatible; UpNext app for SailfishOS)");
        xhr.send();
    }

    SilicaListView {
        id: listView
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
                id: primeMenuAction
                text: "20:15"
                onClicked: {
                    console.log("primeMenuAction clicked")
                    pageStack.push(Qt.resolvedUrl("prime.qml"))
                }

            }

            MenuItem {
                id: nextMenuAction
                text: "Next"
                onClicked: {
                    console.log("nextMenuAction clicked")
                    pageStack.push(Qt.resolvedUrl("next.qml"))
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

        Component.onCompleted: {
            load();
        }

        VerticalScrollDecorator { }

        header: PageHeader {
            title: "UpNext"
        }

        model: programlist
        delegate: Item {
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
            }
        }
    }

    ViewPlaceholder {
        id: message
        enabled: false
    }

    BusyIndicator {
        id: progress
        visible: false
        running: visible
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }
}
