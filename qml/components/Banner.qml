
import QtQuick 2.1
import Sailfish.Silica 1.0

Rectangle {
    id: root
    width: parent.width
    height: Theme.itemSizeMedium
    color: Theme.highlightColor
    anchors.top: parent.top
    visible: false
    z: 256

    function alert(text) {
        label.text = text
        visible = true
        timer.start()
    }

    Behavior on opacity {
        FadeAnimation {  }
    }

    Label {
        id: label
        anchors.centerIn: parent
    }

    Timer {
        id: timer
        interval: 2048
        onTriggered:{
            root.visible = false
        }
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        onClicked: {
            root.visible = false
        }
    }
}
