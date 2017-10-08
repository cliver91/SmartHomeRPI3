import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0


Page {
    id: mynumpad

    signal numkey (string numkeysend)
    signal numbackspacekey(bool numbackspacesend)

    Column {
        id: numcolumns
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Row {
            id: uno23
            spacing: 10
            Rectangle {
               id: uno
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("1")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("1")
                   }
               }
            }
            Rectangle {
               id: dos
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("2")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("2")
                   }
               }
            }
            Rectangle {
               id: tres
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("3")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("3")
                   }
               }
            }
        }
        Row {
            id: cuatro56
            spacing: 10
            Rectangle {
               id: cuatro
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("4")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("4")
                   }
               }
            }
            Rectangle {
               id: cinco
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("5")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("5")
                   }
               }
            }
            Rectangle {
               id: seis
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("6")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("6")
                   }
               }
            }
        }
        Row {
            id: siete89
            spacing: 10
            Rectangle {
               id: siete
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("7")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("7")
                   }
               }
            }
            Rectangle {
               id: ocho
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("8")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("8")
                   }
               }
            }
            Rectangle {
               id: nueve
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("9")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("9")
                   }
               }
            }
        }
        Row {
            id: mas0asterisco
            spacing: 10
            Rectangle {
               id: mas
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("+")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("+")
                   }
               }
            }
            Rectangle {
               id: cero
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("0")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("0")
                   }
               }
            }
            Rectangle {
               id: asterisco
               width: 60
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("*")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mynumpad.numkey("*")
                   }
               }
            }

        }
        Rectangle {
            id: numbackspace
            width:200
            height: 40
            color: "#CCCCCC"
            Button {
                text: qsTr("Backspace")
                anchors.centerIn: parent
                anchors.fill: parent
                onClicked: {
                    mynumpad.numbackspacekey(true)      //Envia el cambio de estado en la senal para los archivos que hayan llamado al numkey
                }
            }
        }


    }
}
