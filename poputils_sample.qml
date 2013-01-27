import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1

Rectangle{
    id: root
    width: units.gu(100)
    height: units.gu(60)
    color: "palegoldenrod"
    Component {
         id: dialog
         Dialog {
             id: dialogue
             title: "Save file"
             text: "Are you sure that you want to save this file?"
             Button {
                 text: "cancel"
                 onClicked: PopupUtils.close(dialogue)
             }
             Button {
                 text: "overwrite previous version"
                 color: "orange"
                 onClicked: PopupUtils.close(dialogue)
             }
             Button {
                 text: "save a copy"
                 color: "orange"
                 onClicked: PopupUtils.close(dialogue)
             }
         }
    }
    Button {
        anchors.centerIn: parent
        id: saveButton
        text: "save"
        onClicked: PopupUtils.open(dialog, saveButton)
    }
}
