import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    id: root
    width: units.gu(60)
    height: units.gu(30)
    color: "palegoldenrod"

    ListModel {
        id: mylistmodel
        ListElement{
            name:"Açaí"
            scient:"Euterpe oleracea"
            price: 10.5
        }
        ListElement{
            name:"Acerola"
            scient:"Malpighia glabra"
            price: 2.4
        }
        ListElement{
            name:"Aguaymanto"
            scient:"Physalis peruviana"
            price: 4.3
        }
        ListElement{
            name:"Almendra malabar"
            scient:"Terminalia catappa"
            price: 8.9
        }
    }
    ListView {
        id: mylistview
         width: units.gu(20)
         height: units.gu(6)
         property int currentIndex:0
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         model: mylistmodel
         delegate:
             Rectangle {
                 id: wrapper
                 width: units.gu(20)
                 height: datainfo.height
                 Text {
                     id: datainfo
                     text: name + ": " + price
                     height: units.gu(3)
                 }
                 MouseArea{
                     anchors.fill: parent
                     onClicked:{
                         mylistview.currentIndex = index
                         console.log(mylistview.currentItem)
                         console.log(mylistmodel.get(index).name)
                     }
                 }
             }
     }
}

