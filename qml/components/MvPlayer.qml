import QtQuick 2.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
//import QtSystemInfo 5.0
//import Sailfish.Media 1.0


Rectangle {
    id: root

    property string code: ""
    property var content

    z: 128
    width: parent.width
    height: Theme.itemSizeHuge
    anchors.bottom: parent.bottom
    color: Theme.rgba(Theme.highlightDimmerColor, 0.4)

    onCodeChanged: {
        content = JSON.parse(content = music163.song(code))
        console.log("content", content)
    }

    Video {
        id: audio
        autoLoad: true
        autoPlay: true
        source:content ? content.songs[0].mp3Url : ""
    }


    Slider {
        z: 256
        anchors.top: parent.top
        width: parent.width
        value: audio.position
        maximumValue: audio.duration ? audio.duration : 0.2
        minimumValue: 0
        opacity: audio.seekable ? 1 : 0.4
        onReleased: {
            console.log(value)
            audio.seek(value)
        }
    }

    Row {
        z: 256
        height: Theme.itemSizeExtraSmall
        spacing: Theme.paddingMedium
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingMedium
        anchors.horizontalCenter: parent.horizontalCenter

        IconButton {
            icon.source: "image://theme/icon-m-previous-song"
            icon.height: Theme.itemSizeExtraSmall
            icon.width: Theme.itemSizeExtraSmall
            onClicked: {

            }
        }

        IconButton {
            icon.source: "image://theme/icon-l-play"
            icon.height: Theme.itemSizeExtraSmall
            icon.width: Theme.itemSizeExtraSmall
            onClicked: {
                audio.playbackState === audio.PlayingState ? audio.pause() : audio.play()
            }
        }

        IconButton {
            icon.source: "image://theme/icon-m-next-song"
            icon.height: Theme.itemSizeExtraSmall
            icon.width: Theme.itemSizeExtraSmall

            onClicked: {

            }
        }

    }

}




