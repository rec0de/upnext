# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = UpNext

CONFIG += sailfishapp

SOURCES += src/UpNext.cpp

OTHER_FILES += qml/UpNext.qml \
    rpm/UpNext.spec \
    rpm/UpNext.yaml \
    UpNext.desktop \
    qml/pages/cover.qml \
    qml/pages/about.qml \
    qml/pages/FirstPage.qml

