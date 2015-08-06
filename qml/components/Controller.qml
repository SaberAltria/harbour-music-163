import QtQuick 2.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import harbour.music163.core 1.0
//import QtSystemInfo 5.0
//import Sailfish.Media 1.0

Rectangle {
    id: root

    z: 128
    width: parent.width
    height: Theme.itemSizeHuge
    anchors.bottom: parent.bottom
    color: Theme.rgba(Theme.highlightDimmerColor, 0.6)

    Slider {
        id: slider
        z: 256
        anchors.top: parent.top
        anchors.topMargin: Theme.paddingLarge * 2
        width: parent.width
        height: Theme.itemSizeExtraSmall
        maximumValue: player.duration
        minimumValue: 0
        stepSize: 1
        value: player.position
        handleVisible: true
        valueText: formatTime(value)

        onReleased: {
            player.position = value
        }

        Binding {
            target: slider
            property: "value"
            value: player.position
        }

        function formatTime(milliseconds)
        {
              var seconds = Math.floor((milliseconds / 1000) % 60)
              var minutes = Math.floor((milliseconds / (60 * 1000)) % 60)
              return minutes + " : " + seconds
        }
    }

    Row {
        z: 128
        height: Theme.iconSizeExtraSmall
        spacing: Theme.paddingLarge
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge * 2
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: player.artist
            color: Theme.primaryColor
        }

        IconButton {
            icon.source: "image://icons/pause"
            icon.height: parent.height
            icon.width: icon.height
            onClicked: {
                player.pause()
            }
        }

        IconButton {
            icon.source: "image://icons/play"
            icon.height: parent.height
            icon.width: icon.height
            onClicked: {
                player.play()
            }
        }

        IconButton {
            icon.source: "image://icons/next"
            icon.height: parent.height
            icon.width: icon.height

            onClicked: {
                player.next()
            }
        }

        IconButton {
            icon.source: "image://icons/loop"
            icon.height: parent.height
            icon.width: icon.height

            onClicked: {

                for ( var i = 0; i < playlist.value.length; i++ ) {
                    player.addToPlaylist(playlist.value[i].artist, playlist.value[i].song, playlist.value[i].url)
                }

                player.play()

            }
        }
    }

}




