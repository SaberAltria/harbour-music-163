import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.music163.core 1.0
import "../components"

Page {

    id: root
    property bool attached: false

    onStatusChanged: {
        if ( root.status === PageStatus.Active && !attached ) {
            pageStack.pushAttached(Qt.resolvedUrl("SearchPage.qml"))
            attached = true
        }
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        anchors.bottomMargin: Theme.itemSizeHuge
        model: playlist.value.length
        spacing: Theme.paddingSmall
        clip: true

        VerticalScrollDecorator {  }

        ViewPlaceholder {
            enabled: playlist.value.length === 0
            text: "（ Empty ）"
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Clear")
                onClicked: {
                    playlist.value = []
                }
            }
        }

        header: PageHeader {
            title: "Playlist"
        }

        delegate: Component {
            PlaylistDelegate {
                id: delegate
                code: playlist.value[index].code
                url: playlist.value[index].url
                artist: playlist.value[index].artist
                album: playlist.value[index].album
                song: playlist.value[index].song
                lyric: playlist.value[index].lyric
            }
        }
    }
}
