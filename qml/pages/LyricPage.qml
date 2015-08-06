import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.music163.core 1.0

Page {
    id: root


    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        anchors.bottomMargin: Theme.itemSizeHuge
        contentHeight: column.height
        clip: true


        PullDownMenu {
            MenuItem {
                text: qsTr("Share")
                onClicked: {
                    Clipboard.text = text.text
                }
            }
        }

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge

            PageHeader {
                title: qsTr("Lyric")
                width: parent.width
            }

            Text {
                id: text
                text: lyric.lrc.lyric.replace(/\[\S*\]/g, "")
                width: parent.width
                color: Theme.primaryColor
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeMedium
            }
        }

    }
}
