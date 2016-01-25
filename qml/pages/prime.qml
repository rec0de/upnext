import QtQuick 2.0
import Sailfish.Silica 1.0
import "../data.js" as DB
import "../components"

Page {
    id: page

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
        var url = 'https://rec0de.net/upnext/new/prime.html';
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

                    text = text.replace('& ', 'und '); // Fixes a weird bug...
                    text = text.replace('&#039;', '\'');
                    text = text.replace('&nbsp;', ' ');
                    text = text.replace('&hellip;', '...');

                    var programarray = text.split('|')

                    pullDownMenu.busy = false;

                    for (var i = 0; i < 14; i++) {

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
                    pullDownMenu.busy = false;
                    message.visible = true;
                }
            }
        }

        xhr.ontimeout = function() {
            pullDownMenu.busy = false;
            message.visible = true;
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
                id: refreshMenuAction
                text: "Refresh"
                onClicked: {
                    load()
                }
            }

        }

        Component.onCompleted: {
            load();
        }

        VerticalScrollDecorator { }

        header: PageHeader {
            title: "Primetime"
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
                anchors.fill : parent
                onClicked: parent.visible = false
            }
        }
    }
}
