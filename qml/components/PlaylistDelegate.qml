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
    property string cover
    property string lyric

    width: parent.width
    height: contextMenu !== null ? Theme.itemSizeSmall + contextMenu.height : Theme.itemSizeSmall

    property Item contextMenu

    Component {
        id: contextMenuComponent

        ContextMenu {

            width: root.width
            MenuItem {
                text: "Delete"
                onClicked: {
                    var record = playlist.value
                    record.splice(index, 1)
                    playlist.value = record
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
        height: Theme.itemSizeSmall

        Label {
            text: artist + " - " + song
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeSmall
            elide: Text.ElideMiddle
            maximumLineCount: 1
            horizontalAlignment: Text.AlignJustify
            verticalAlignment: Text.AlignVCenter
        }

        Separator {
            color: Theme.highlightColor
            width: parent.width
            anchors.bottom: parent.bottom
        }

        onPressAndHold: {
            contextMenu = contextMenuComponent.createObject(listView)
            contextMenu.show(root)
        }

        onClicked: {
            player.artist =artist
            player.song = song
            player.code = code
        }
    }
}
