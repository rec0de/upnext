import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica 1.0

Page {
    id: page


    property alias _resText: resLabel.text



    SilicaFlickable {
        anchors.fill: parent



        // Tell SilicaFlickable the height of its content.
        contentHeight: childrenRect.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            anchors.fill: parent
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingLarge
            PageHeader {
                title: "About"
            }

            Label {
                id: resLabel
                text: "Made by @rec0denet<br><br>This app has no license.<br>Do whatever you want.<br>But please dont steal my icon.<br><br> Also, this app is complete crap.<br>If you can do it any better,<br>please contact me: mail@rec0de.net <br><br>Source: <a href='https://github.com/rec0de/upnext'>github.com/rec0de/upnext</a><br><br>This App is based on 'Helloworld Pro'<br>by Artem Marchenko. Thanks a lot!"
            }
        }
    }

}
