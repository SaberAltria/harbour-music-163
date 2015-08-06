import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.music163.core 1.0
import "../Library.js" as Lib
Item {
    id: root

    property string code
    property string url
    property string artist
    property string album
    property string song

    width: parent.width
    height: contextMenu !== null ? Theme.itemSizeExtraLarge + contextMenu.height : Theme.itemSizeExtraLarge

    property Item contextMenu

    Component {
        id: contextMenuComponent

        ContextMenu {

            width: root.width
            MenuItem {
                text: qsTr("Add to Playlist")
                onClicked: {
                    //Song
                    var data = JSON.parse(data = music163.song(code))

                    console.log("", JSON.stringify(data))

                    Lib.addToPlaylist(code, data.songs[0].mp3Url, artist, album, song, data.songs[0].album.picUrl, "")
                }
            }
            MenuItem {
                text: qsTr("Download")
                onClicked: {
                    music163.save(url, artist + " - " + song + ".mp3")
                }
            }
        }
    }

    BackgroundItem {
        width: parent.width
        height: Theme.itemSizeExtraLarge

        onPressAndHold: {
            contextMenu = contextMenuComponent.createObject(listView)
            contextMenu.show(root)
        }

        Row {
            height: parent.height
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge

            Label {
                text: album
                width: Theme.itemSizeHuge
                maximumLineCount: 2
                truncationMode: TruncationMode.Fade
                font.pixelSize: Theme.fontSizeSmall
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
            }

            Label {
                text: song
                width: parent.width - Theme.itemSizeHuge - Theme.itemSizeMedium
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.Wrap
                maximumLineCount: 2
                truncationMode: TruncationMode.Fade
            }

            Column {
                width: Theme.itemSizeMedium
                spacing: Theme.paddingSmall
                anchors.verticalCenter: parent.verticalCenter

                Label {
                    text: artist
                    width: parent.width
                    truncationMode: TruncationMode.Fade
                    maximumLineCount: 1
                    font.pixelSize: Theme.fontSizeExtraSmall
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        onClicked: {
            player.artist = artist
            player.song = song
            player.code = code
        }

        Separator {
            color: Theme.highlightColor
            width: parent.width
            anchors.bottom: parent.bottom
        }
    }
}
