import QtQuick 2.0

Item {
    property alias color : rectangle.color

    BorderImage {
        anchors.fill: rectangle
        //anchors { leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        anchors { topMargin: -8; bottomMargin: -8 }
        border { top: 5; bottom: 5 }
        source: Qt.resolvedUrl("innershadow.png"); smooth: true
    }

    Rectangle { id: rectangle; anchors.fill: parent }
}
