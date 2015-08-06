import QtQuick 2.1
import Sailfish.Silica 1.0

Image {
    height: parent.height
    width: parent.width * 2
    fillMode: Image.PreserveAspectCrop
    opacity: 0.6

    x: - ( Theme.itemSizeHuge * pageStack.depth )

    Behavior on x {
        SmoothedAnimation {
            duration: 2048
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#BB000000"
    }

}
