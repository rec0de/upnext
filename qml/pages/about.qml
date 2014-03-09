import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: childrenRect.height

        Column {
            anchors.fill: parent
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingMedium

            PageHeader {
                title: "About"
            }

            SectionHeader {
                text: "License"
            }

            Label {
                text: "The Unlicense"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    id : licenseMouseArea
                    anchors.fill : parent
                    onClicked: Qt.openUrlExternally("http://unlicense.org")
                }
            }

            SectionHeader {
                text: "Made by"
            }

            Label {
                text: "@rec0denet"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    id : madebyMouseArea
                    anchors.fill : parent
                    onClicked: Qt.openUrlExternally("http://rec0de.net")
                }
            }

            SectionHeader {
                text: "Source"
            }

            Label {
                text: "github.com/rec0de/upnext"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    id : sourceMouseArea
                    anchors.fill : parent
                    onClicked: Qt.openUrlExternally("https://github.com/rec0de/upnext")
                }
            }


            SectionHeader {
                text: "Contact"
            }

            Label {
                text: "mail@rec0de.net <br> GnuPG available"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    id : contactMouseArea
                    anchors.fill : parent
                    onClicked: Qt.openUrlExternally("mailto:mail@rec0de.net")
                }
            }

            SectionHeader {
                text: "Other stuff"
            }

            Label {
                id: body
                text: 'This App is based on "Helloworld Pro" by Artem Marchenko. Thanks a lot!<br>Further thanks to the Tweetian devs and thesignal, developer of "ohm"!'
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
            }
        }
    }

}
