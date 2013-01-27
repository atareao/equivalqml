import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "parser.js" as JS

Rectangle{
    id: root
    width: units.gu(50)
    height: units.gu(90)
    color:"lightgray"
    Component.onCompleted: {
        console.log('loading');
        JS.loadtxt(myspeciallabel);
        console.log('myspeciallabel loaded');
    }/*
    Component {
                 id: dialog
                 Dialog {
                     id: dialogue
                     title: "Guardar"
                     text: "Estas seguro?"
                     Button {
                         text: "Cancelar"
                         onClicked: PopupUtils.close(dialogue)
                     }
                     Button {
                         text: "Sobreescribir"
                         color: "orange"
                         onClicked: PopupUtils.close(dialogue)
                     }
                     Button {
                         text: "Guardar"
                         color: "orange"
                         onClicked: PopupUtils.close(dialogue)
                     }
                 }
            }
    Component {
        id: composerSheet
        ComposerSheet {
            id: sheet
            title: "Composer sheet"
            width: units.gu(30)
            Label {
                text: "A composer sheet has cancel and confirm buttons."
            }
            onCancelClicked: PopupUtils.close(sheet)
            onConfirmClicked: PopupUtils.close(sheet)
       }
    }
    Component {
        id: defaultSheet
        DefaultSheet {
            id: sheet
            title: "Default sheet with done button"
            width:units.gu(10)
            doneButton: true
            Label {
                text: "A default sheet with a done button."
                wrapMode: Text.WordWrap
            }
            onDoneClicked: PopupUtils.close(sheet)
        }
    }*/
    Tabs {
        ItemStyle.class: "new-tabs"
        id: tabs
        selectedTabIndex: 2
        anchors.fill: parent
        Tab {
            title: "Tipo desplazable"
            page: Rectangle {
                anchors.fill: parent
                color: "#eeeeee"

                Flickable {
                    id: flickable
                    clip: true
                    anchors.fill: parent
                    contentHeight: column.height
                    contentWidth: parent.width
                    flickableDirection: Flickable.VerticalFlick

                    Column {
                        id: column
                        width: parent.width
                        height: childrenRect.height

                        Label {
                            text: "\n\n\n Este control sirve para mostrar un texto realmente largo \n\n\n"
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label{
                            id: myspeciallabel
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label {
                            text: "\n\n\nFinal"
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
        Tab {
            title: "Mis botones"
            page: Rectangle {
                anchors.fill:parent
                color: "tan"
                Column{
                    anchors.centerIn: parent
                    Row{
                        Button {
                            id: button1
                            width: units.gu(25)
                            text: "A la anterior"
                            onClicked: tabs.selectedTabIndex--
                        }
                    }
                    Row{
                        UbuntuShape {
                            width: units.gu(25)
                            color: "lightblue"
                            radius: "medium"
                        }
                    }
                    Row{
                        Button {
                            id: button2
                            width: units.gu(25)
                            text: "A la anterior"
                            onClicked: tabs.selectedTabIndex--
                        }
                    }

                }
            }
        }
        Tab {
            title: "Una pila de páginas"
            page:PageStack {
                   id: pageStack
                   anchors.fill: parent

                    Component.onCompleted: pageStack.push(page0)

                    Page {
                        id: page0
                        title: "Pagina principal"
                        anchors.fill: parent

                        Column {
                            anchors.fill: parent
                            ListItem.Standard {
                                text: "Primera página"
                                onClicked: pageStack.push(rect, {color: "red"})
                                progression: true
                            }
                            ListItem.Standard {
                                text: "Segunda página (un enlace externo a otro ejemplo)"
                                onClicked: pageStack.push(Qt.resolvedUrl("popover_sample.qml"))
                                progression: true
                            }
                        }
                    }

                    Rectangle {
                        id: rect
                        anchors.fill: parent
                        visible: false
                    }
                }
        }
        Tab {
            title: "Un ListView"
            page: ListView {
                clip: true
                anchors.fill: parent
                model: 20
                delegate: ListItem.Standard {
                    text: "Item "+modelData
                }
            }
        }
        Tab{
            title: "Otros ejemplos"
            page:
                Column{
                    anchors.centerIn: parent
                    Row{
                        Button {
                            id: buttondefault
                            text: "default"
                            width: units.gu(20)
                            onClicked: PopupUtils.open(defaultSheet)
                        }
                    }
                    Row{
                        Button {
                            text: "composerSheet"
                            width: units.gu(20)
                            onClicked: PopupUtils.open(composerSheet)
                        }
                    }
                    Row{
                        Button {
                            id: saveButton
                            text: "Guardar"
                            width: units.gu(20)
                            onClicked: PopupUtils.open(dialog, saveButton)
                        }
                    }
            }
        }
    }
}
