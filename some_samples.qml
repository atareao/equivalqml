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
        activity.running = true;
    }
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
                text: "Este tipo de sheet tiene botón de aceptar y cancelar."
            }
            onCancelClicked: PopupUtils.close(sheet)
            onConfirmClicked: PopupUtils.close(sheet)
       }
    }
    Component {
        id: defaultSheet
        DefaultSheet {
            id: sheet
            title: "Default sheet"
            anchors.fill: parent
            doneButton: true
            Label {
                text: "Este tipo puede tener botón de confirmar."
                wrapMode: Text.WordWrap
            }
            onDoneClicked: PopupUtils.close(sheet)
        }
    }
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
                Scrollbar {
                            flickableItem: flickable
                            align: Qt.AlignTrailing
                        }
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
        Tab{
            title: "Controles"
            page:
                Column{
                    anchors.centerIn: parent
                    spacing: units.gu(1)
                    Row{
                        ActivityIndicator {
                            id: activity
                            MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        activity.running = !activity.running;
                                        switchbox.checked = activity.running;
                                        checkbox.checked = activity.running;
                                    }
                                }
                        }
                    }
                    Row{
                        CheckBox {
                            id: checkbox;
                            checked: true
                            onClicked: {
                                switchbox.checked = checked;
                                activity.running = checked;
                            }
                       }
                    }
                    Row{
                        ProgressBar {
                                    id: progressbar
                                    minimumValue: 0.0
                                    maximumValue: 10.0
                                    value:5.0
                                }
                    }
                    Row{
                        Slider {
                                    function formatValue(v) { return v.toFixed(1) }
                                    minimumValue: 0.0
                                    maximumValue: 10.0
                                    value: 5.0
                                    live: true
                                    onClicked: {
                                        progressbar.value = value;
                                    }
                                }
                    }
                    Row{
                        Switch {
                            id: switchbox
                            checked: true
                            onClicked: {
                                checkbox.checked = checked;
                                activity.running = checked;
                                }
                            }
                    }
                    Row{
                        TextArea{
                            id: mytextarea
                            text: "Esto es una prueba"
                        }
                    }
                    Row{
                        TextField {
                            placeholderText: "Escribe algo aquí"
                            validator: RegExpValidator { regExp: /\d{8}-[A-Z]|X-\d{7}-[A-Z]/ }
                        }
                    }
            }
        }
    }
}
