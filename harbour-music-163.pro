# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-music-163

CONFIG += sailfishapp

SOURCES += src/harbour-music-163.cpp \
    src/music163.cpp \
    src/player.cpp

QT += network \
multimedia

OTHER_FILES += qml/harbour-music-163.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-music-163.changes.in \
    rpm/harbour-music-163.spec \
    rpm/harbour-music-163.yaml \
    translations/*.ts \
    harbour-music-163.desktop \
    qml/Library.js \
    qml/pages/SearchPage.qml \
    qml/components/MvPlayer.qml \
    qml/pages/AlbumInfoPage.qml \
    qml/pages/SingleInfoPage.qml \
    qml/components/FullScreenCover.qml \
    qml/pages/PlaylistPage.qml \
    qml/components/Banner.qml \
    qml/pages/LyricPage.qml \
    qml/icons/play.png \
    qml/icons/download.png \
    qml/icons/next.png \
    qml/icons/pause.png \
    qml/icons/previous.png \
    qml/components/PlaylistDelegate.qml \
    qml/components/SearchDelegate.qml \
    qml/components/Controller.qml \
    qml/components/MusicPlayer.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-music-163-zh_CN.ts \
translations/harbour-music-163-zh_HK.ts

HEADERS += \
    src/music163.h \
    src/player.h \
    src/iconProvider.h

