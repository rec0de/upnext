# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-upnext

CONFIG += sailfishapp

SOURCES += src/harbour-upnext.cpp

OTHER_FILES += qml/harbour-upnext.qml \
    rpm/harbour-upnext.spec \
    rpm/harbour-upnext.yaml \
    harbour-upnext.desktop \
    qml/pages/cover.qml \
    qml/pages/about.qml \
    qml/pages/FirstPage.qml \
    qml/pages/prime.qml \
    qml/pages/next.qml \
    qml/data.js \
    qml/components/ProgramItem.qml \
    qml/pages/about2.qml

