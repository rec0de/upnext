import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica 1.0


Page {
    id: page

    property alias _refreshMenuAction: refreshMenuAction
    property alias _aboutMenuAction: aboutMenuAction


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
        ListElement {
            name: "Sat1"
            program: "..."
        }
        ListElement {
            name: "Vox"
            program: "..."
        }
        ListElement {
            name: "Arte"
            program: "..."
        }
        ListElement {
            name: "Phoenix"
            program: "..."
        }
        ListElement {
            name: "WDR"
            program: "..."
        }
        ListElement {
            name: "SRF1"
            program: "..."
        }

    }

    function load() {
        var url = 'https://cdown.pf-control.de/upnext/new/prime.html'; // alias domain for rec0de.net with valid SSL cert
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

                    text = text.replace('&', 'und'); // Fixes a weird bug...

                    var programarray = text.split('|')

                    progress.visible = false;

                    for (var i = 0; i < 12; i++) {

                        if(programarray[i] == ' '){
                            programarray[i] = 'Error :('
                        }

                    programlist.set(i, {"program": programarray[i]})
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
                title: "Primetime"
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
                text: load() // Some sort of workaround for loading on startup
            }

            ListView {
                model: programlist
                width: parent.width
                height: parent.height - 100
                boundsBehavior: Flickable.StopAtBounds
                delegate: Column {
                    width: parent.width

                    Label {
                        width: parent.width
                        text: name
                    }

                    Label {
                        width: parent.width
                        text: program
                        truncationMode: TruncationMode.Fade
                    }
                    // Spacer
                    Label {
                        width: parent.width
                        text: ''
                    }


                }
            }


        }
    }

}
