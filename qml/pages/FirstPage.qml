import QtQuick 2.0
import Sailfish.Silica 1.0
import "../data.js" as DB
import "../components"

Page {
    id: page

    Component.onCompleted: {
        // Initialize the database
        DB.initialize();
        load();
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
        ListElement {
            name: "NDR"
            program: "..."
            active: true
        }
        ListElement {
            name: "RTL2"
            program: "..."
            active: true
        }
    }

    function load() {
        var url = 'https://rec0de.net/upnext/new/';
        pullDownMenu.busy = true;
        message.visible = false;

        var xhr = new XMLHttpRequest();
        xhr.timeout = 1000;

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if(xhr.status >= 200 && xhr.status < 300) {

                    var text = xhr.responseText;

                    //Escaping content fetched from web to prevent script injections
                    var patt1 = /(<|>|\{|\}|\[|\]|\\)/g;
                    text = text.replace(patt1, '');

                    text = text.replace('& ', 'und '); // Fixes a weird bug... //Causes more bugs... TODO
                    text = text.replace('&#039;', '\'');
                    text = text.replace('&nbsp;', ' ');
                    text = text.replace('&hellip;', '...');

                    var programarray = text.split('|')

                    pullDownMenu.busy = false;
                    //listView.visible = true;


                    for (var i = 0; i < 14; i++) {

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
                    //listView.visible = false;
                    pullDownMenu.busy = false;
                    message.visible = true;
                    messagetext.text = 'Something went wrong.';
                }
            }
        }

        xhr.ontimeout = function() {
            listView.visible = false;
            pullDownMenu.busy = false;
            message.visible = true;
            messagetext.text = 'Error: Request timed out.';
        }

        xhr.open('GET', url, true);
        xhr.setRequestHeader("User-Agent", "Mozilla/5.0 (compatible; UpNext app for SailfishOS)");
        xhr.send();
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: programlist
        delegate: ProgramItem {
            senderName: name
            programText: program
        }

        PullDownMenu {
            id: pullDownMenu
            busy: false
            MenuItem {
                id: aboutMenuAction
                text: "About & Settings"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("about.qml"))
                }

            }

            MenuItem {
                id: primeMenuAction
                text: "20:15"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("prime.qml"))
                }

            }

            MenuItem {
                id: nextMenuAction
                text: "Next"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("next.qml"))
                }

            }

            MenuItem {
                id: refreshMenuAction
                text: "Refresh"
                onClicked: {
                    load()
                }

            }

        }

        VerticalScrollDecorator { }

        header: PageHeader {
            title: "UpNext"
        }

        Rectangle {
            id: message
            visible: false
            anchors.centerIn: parent
            width: page.width
            height: Theme.itemSizeLarge
            color: Theme.highlightColor
            Label{
                id: messagetext
                visible: parent.visible
                anchors.centerIn: parent
                text: 'Something went wrong'
                font.pixelSize: Theme.fontSizeLarge
            }
            MouseArea {
                id : messagemousearea
                anchors.fill : parent
                onClicked: parent.visible = false
            }
        }

    }
}
