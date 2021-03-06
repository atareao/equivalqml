import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1
import "parser.js" as JS
Rectangle {
    id: root
    width: units.gu(60)
    height: units.gu(30)
    color: "lightgray"

    property real margins: units.gu(2)
    property real buttonWidth: units.gu(15)

    Label {
       id: title
       ItemStyle.class: "title"
       text: i18n.tr("Equival")
       height: contentHeight + root.margins
       anchors {
           left: parent.left
           right: parent.right
           top: parent.top
       }
    }

    ListModel {
        id:magnitudeModel
        function getIndex(idx) {
            return (idx >= 0 && idx < count) ? idx: -1
        }
        function getValue(idx) {
            return (idx >= 0 && idx < count) ? get(idx).key: ""
        }
    }

    Component {
        id: magnitudeSelector
        Popover{
            Column {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: pageLayout.height
                Header {
                    id: header
                    text: i18n.tr("Select magnitude")
                }
                ListView {
                    clip: true
                    width: parent.width
                    height: parent.height - header.height
                    model: magnitudeModel
                    delegate: Standard {
                        text: key
                        onClicked:{
                            caller.magnitudeIndex = index
                            JS.loadUnits(theunits,magnitudeModel.get(index).unidades,selectorFrom,selectorTo)
                            hide()
                        }
                    }
                }
            }
        }
    }
    ListModel {
        id: theunits
    }

    Component {
        id: unitSelector
            Popover {
                Column {
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    height: pageLayout.height
                    Header {
                        id: header
                        text: i18n.tr("Select unit")
                    }
                    ListView {
                        clip: true
                        width: parent.width
                        height: parent.height - header.height
                        model: theunits
                        delegate: Standard {
                            text: key
                            onClicked:{
                                caller.unitIndex = index
                                caller.unitFactor = factor
                                caller.text = key
                                caller.input.update()
                                hide()
                        }
                    }
                }
            }
        }
    }
    function convert(from, fromFactor, toFactor) {
        var value = parseFloat(from);
        return String(value * fromFactor/toFactor);

        /*
        var fromUnit = theunits.getValue(fromUnitIndex);
        var toUnit  = theunits.getValue(toUnitIndex);
        var value = parseFloat(from);
        if (from.length <= 0){
            return "";
        }
        if (fromUnit === "C"){
            if (toUnit === "C"){
                return from;
            }else if (toUnit === "F"){
                return String(value*9/5+32);
            }else if (toUnit === "K"){
                return String(value+273.15);
            }else if (toUnit === "R"){
                return String(value * 1.8 + 32 + 459.67);
            }
        }else if (fromUnit === "F"){
            if (toUnit === "C"){
                return String((value - 32) / 1.8);
            }else if (toUnit === "F"){
                return from;
            }else if (toUnit === "K"){
                return String((value + 459.67) / 1.8);
            }else if (toUnit === "R"){
                return String(value + 459.67);
            }

        }else if (fromUnit === "K"){
            if (toUnit === "C"){
                return String(value - 273.15);
            }else if (toUnit === "F"){
                return String(value * 1.8 - 459.67);
            }else if (toUnit === "K"){
                return from;
            }else if (toUnit === "R"){
                return String(value*1.8);
            }
        }else if (fromUnit === "R"){
            if (toUnit === "C"){
                return String((value - 32 - 459.67) / 1.8);
            }else if (toUnit === "F"){
                return String(value+459.67);
            }else if (toUnit === "K"){
                return String(value/1.8);
            }else if (toUnit === "R"){
                return String(value*1.8);
            }
        }
        */
        return "";
    }
    Column {
        id: pageLayout

        anchors {
            fill: parent
            margins: root.margins
            topMargin: title.height
        }
        spacing: units.gu(1)
        Row {
            spacing: units.gu(1)

            Button {
                id: selectorMagnitude
                width: pageLayout.width - 2 * root.margins + units.gu(1)
                property int magnitudeIndex: 0
                text: magnitudeModel.getValue(magnitudeIndex)
                onClicked: PopupUtils.open(magnitudeSelector, selectorMagnitude)
            }
        }

        Row {
            spacing: units.gu(1)

            Button {
                id: selectorFrom
                width: root.buttonWidth
                property int unitIndex: 0
                property double unitFactor: 0.0
                property TextField input: inputFrom
                text: theunits.get(unitIndex).key
                onClicked: PopupUtils.open(unitSelector, selectorFrom)
            }

            TextField {
                id: inputFrom
                errorHighlight: false
                validator: DoubleValidator {notation: DoubleValidator.StandardNotation}
                width: pageLayout.width - 2 * root.margins - root.buttonWidth
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: '0.0'
                onTextChanged: {
                    if (activeFocus) {
                        inputTo.text = convert(inputFrom.text, selectorFrom.unitFactor, selectorTo.unitFactor)
                    }
                }
                function update() {
                    text = convert(inputTo.text, selectorTo.unitFactor, selectorFrom.unitFactor)
                }
            }
        }

        Row {
            spacing: units.gu(1)
            Button {
                id: selectorTo
                width: root.buttonWidth
                property int unitIndex: 0
                property double unitFactor: 0.0
                property TextField input: inputTo
                text: theunits.get(unitIndex).key
                onClicked: PopupUtils.open(unitSelector, selectorTo)
            }

            TextField {
                id: inputTo
                errorHighlight: false
                validator: DoubleValidator {notation: DoubleValidator.StandardNotation}
                width: pageLayout.width - 2 * root.margins - root.buttonWidth
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: '0.0'
                onTextChanged: {
                    if (activeFocus) {
                        inputFrom.text = convert(inputTo.text, selectorTo.unitFactor, selectorFrom.unitFactor)
                    }
                }
                function update() {
                    text = convert(inputFrom.text, selectorFrom.unitFactor, selectorTo.unitFactor)
                }
            }
        }

        Button {
            text: i18n.tr("Clear")
            width: units.gu(12)
            onClicked: {
                inputTo.text = '0.0';
                inputFrom.text = '0.0';
            }
        }
    }
    Component.onCompleted:{
        JS.load(magnitudeModel,theunits,selectorFrom,selectorTo)
        console.log(magnitudeModel)

        console.log('loaded')
    }
}
