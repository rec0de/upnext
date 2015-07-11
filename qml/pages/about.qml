import QtQuick 2.0
import Sailfish.Silica 1.0
import "../data.js" as DB

Page {
    id: page

    function update(object, id) {
        var state = DB.getText(id);

        if(state != 0){
            object.checked = true;
        }
        else{
            object.checked = false;
        }
    }

    function toggle(oid, id){
        var state = DB.getText(id);

        if(state != 0){
            DB.setNote(id, 0);
            oid.checked = false;
        }
        else{
            DB.setNote(id, 1);
            oid.checked = true;
        }
    }

    function covertoggle(oid, id){
        var state = DB.getCover(id);

        if(state != 0){
            DB.setCover(id, 0);
            oid.checked = false;
        }
        else{
            DB.setCover(id, 1);
            oid.checked = true;
        }
    }

    function coverupdate(object, id) {
        var state = DB.getCover(id);

        if(state != 0){
            object.checked = true;
        }
        else{
            object.checked = false;
        }
    }

    Component.onCompleted: {
        // Initialize the database
        DB.initialize();
        // Load switch states from DB (probably horribly inefficient)
        // TODO: replace this with a loop and array
        update(ard, 1);
        update(zdf, 2);
        update(sat, 3);
        update(kabel, 4);
        update(rtl, 5);
        update(pro, 6);
        update(sateins, 7);
        update(vox, 8);
        update(arte, 9);
        update(phoenix, 10);
        update(wdr, 11);
        update(srf, 12);
        update(ndr, 13);
        update(rtl2, 14);

        coverupdate(card, 1);
        coverupdate(czdf, 2);
        coverupdate(csat, 3);
        coverupdate(ckabel, 4);
        coverupdate(crtl, 5);
        coverupdate(cpro, 6);
        coverupdate(csateins, 7);
        coverupdate(cvox, 8);
        coverupdate(carte, 9);
        coverupdate(cphoenix, 10);
        coverupdate(cwdr, 11);
        coverupdate(csrf, 12);
        coverupdate(cndr, 13);
        coverupdate(crtl2, 14);
    }

    SilicaFlickable {
            anchors.fill: parent
            height: parent.height
            contentHeight: parent.height + 1800

            VerticalScrollDecorator{}


            Column {
                id: content
                anchors.fill: parent
                anchors.margins: Theme.paddingSmall
                spacing: Theme.paddingSmall


            PageHeader {
                title: "Settings"
            }

            SectionHeader {
                text: "Choose channels"
            }

            TextSwitch {
                id: ard
                automaticCheck: false
                text: "ARD"
                onClicked: {
                    toggle(ard, 1)
                }
            }
            TextSwitch {
                id: zdf
                automaticCheck: false
                text: "ZDF"
                onClicked: {
                    toggle(zdf, 2)
                }
            }
            TextSwitch {
                id: sat
                automaticCheck: false
                text: "3sat"
                onClicked: {
                    toggle(sat, 3)
                }
            }
            TextSwitch {
                id: kabel
                automaticCheck: false
                text: "Kabel1"
                onClicked: {
                    toggle(kabel, 4)
                }
            }
            TextSwitch {
                id: rtl
                automaticCheck: false
                text: "RTL"
                onClicked: {
                    toggle(rtl, 5)
                }
            }
            TextSwitch {
                id: pro
                automaticCheck: false
                text: "Pro7"
                onClicked: {
                    toggle(pro, 6)
                }
            }
            TextSwitch {
                id: sateins
                automaticCheck: false
                text: "Sat1"
                onClicked: {
                    toggle(sateins, 7)
                }
            }
            TextSwitch {
                id: vox
                automaticCheck: false
                text: "VOX"
                onClicked: {
                    toggle(vox, 8)
                }
            }
            TextSwitch {
                id: arte
                automaticCheck: false
                text: "Arte"
                onClicked: {
                    toggle(arte, 9)
                }
            }
            TextSwitch {
                id: phoenix
                automaticCheck: false
                text: "Phoenix"
                onClicked: {
                    toggle(phoenix, 10)
                }
            }
            TextSwitch {
                id: wdr
                automaticCheck: false
                text: "WDR"
                onClicked: {
                    toggle(wdr, 11)
                }
            }
            TextSwitch {
                id: srf
                automaticCheck: false
                text: "SRF1"
                onClicked: {
                    toggle(srf, 12)
                }
            }

            TextSwitch {
                id: ndr
                automaticCheck: false
                text: "NDR"
                onClicked: {
                    toggle(ndr, 13)
                }
            }

            TextSwitch {
                id: rtl2
                automaticCheck: false
                text: "RTL2"
                onClicked: {
                    toggle(rtl2, 14)
                }
            }

            SectionHeader {
                text: "Cover Channels (max.6)"
            }

            TextSwitch {
                id: card
                automaticCheck: false
                text: "ARD"
                onClicked: {
                    covertoggle(card, 1)
                }
            }
            TextSwitch {
                id: czdf
                automaticCheck: false
                text: "ZDF"
                onClicked: {
                    covertoggle(czdf, 2)
                }
            }
            TextSwitch {
                id: csat
                automaticCheck: false
                text: "3sat"
                onClicked: {
                    covertoggle(csat, 3)
                }
            }
            TextSwitch {
                id: ckabel
                automaticCheck: false
                text: "Kabel1"
                onClicked: {
                    covertoggle(ckabel, 4)
                }
            }
            TextSwitch {
                id: crtl
                automaticCheck: false
                text: "RTL"
                onClicked: {
                    covertoggle(crtl, 5)
                }
            }
            TextSwitch {
                id: cpro
                automaticCheck: false
                text: "Pro7"
                onClicked: {
                    covertoggle(cpro, 6)
                }
            }
            TextSwitch {
                id: csateins
                automaticCheck: false
                text: "Sat1"
                onClicked: {
                    covertoggle(csateins, 7)
                }
            }
            TextSwitch {
                id: cvox
                automaticCheck: false
                text: "VOX"
                onClicked: {
                    covertoggle(cvox, 8)
                }
            }
            TextSwitch {
                id: carte
                automaticCheck: false
                text: "Arte"
                onClicked: {
                    covertoggle(carte, 9)
                }
            }
            TextSwitch {
                id: cphoenix
                automaticCheck: false
                text: "Phoenix"
                onClicked: {
                    covertoggle(cphoenix, 10)
                }
            }
            TextSwitch {
                id: cwdr
                automaticCheck: false
                text: "WDR"
                onClicked: {
                    covertoggle(cwdr, 11)
                }
            }
            TextSwitch {
                id: csrf
                automaticCheck: false
                text: "SRF1"
                onClicked: {
                    covertoggle(csrf, 12)
                }
            }
            TextSwitch {
                id: cndr
                automaticCheck: false
                text: "NDR"
                onClicked: {
                    covertoggle(cndr, 13)
                }
            }

            TextSwitch {
                id: crtl2
                automaticCheck: false
                text: "RTL2"
                onClicked: {
                    covertoggle(crtl2, 14)
                }
            }

            Button {
               id: about
               anchors.horizontalCenter: parent.horizontalCenter
               text: "About UpNext"
               onClicked: pageStack.push(Qt.resolvedUrl("about2.qml"))
            }

        }
    }

}
