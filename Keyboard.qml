import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0




Page {
    id: mykeyboard

    property bool caps: false
    property string key: ""
    signal keysignal (string keysend)       //Envia el caracter de lo que se presione
    signal enterkey(bool enterkeysend)      //Envia la senal de Enter
    signal backspacekey(bool backspacekeysend)      //Envia la senal de Backspace


    Column {
        id: columns
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        y: 20
        Row {
            id: nums
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
                       mykeyboard.keysignal("1")     //Pone el caracter y cambia el estado para que otro archivo lo detecte
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
                       mykeyboard.keysignal("2")
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
                       mykeyboard.keysignal("3")
                   }
               }
            }
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
                       mykeyboard.keysignal("4")
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
                       mykeyboard.keysignal("5")
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
                       mykeyboard.keysignal("6")
                   }
               }
            }
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
                       mykeyboard.keysignal("7")
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
                       mykeyboard.keysignal("8")
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
                       mykeyboard.keysignal("9")
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
                       mykeyboard.keysignal("0")
                   }
               }
            }

        }
        Row {
            id: qwe
            spacing: 10
            Rectangle {
               id: q
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("Q"):qsTr("q")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("Q"):mykeyboard.keysignal("q")
                   }
               }
            }

            Rectangle {
               id: w
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("W"):qsTr("w")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("W"):mykeyboard.keysignal("w")
                   }
               }
            }
            Rectangle {
               id: e
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("E"):qsTr("e")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("E"):mykeyboard.keysignal("e")
                   }
               }
            }
            Rectangle {
               id: r
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("R"):qsTr("r")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("R"):mykeyboard.keysignal("r")
                   }
               }
            }
            Rectangle {
               id: t
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("T"):qsTr("t")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("T"):mykeyboard.keysignal("t")
                   }
               }
            }
            Rectangle {
               id: y
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("Y"):qsTr("y")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("Y"):mykeyboard.keysignal("y")
                   }
               }
            }
            Rectangle {
               id: u
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("U"):qsTr("u")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("U"):mykeyboard.keysignal("u")
                   }
               }
            }
            Rectangle {
               id: i
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("I"):qsTr("i")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("I"):mykeyboard.keysignal("i")
                   }
               }
            }
            Rectangle {
               id: o
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("O"):qsTr("o")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("O"):mykeyboard.keysignal("o")
                   }
               }
            }
            Rectangle {
               id: p
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("P"):qsTr("p")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("P"):mykeyboard.keysignal("p")
                   }
               }
            }
            Rectangle {
               id: backspace
               width: 90
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("Backspace")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       //Qt.Key_Backspace = true
                       //passinput.cursorPosition -= 1
                       mykeyboard.backspacekey(true)        //Envia una senal booleana para hacer backspace en el qml que corresponda
                   }
               }
            }

        }
        Row {
            id: asd
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
               id: capslock
               width: 70
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("Caps")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       if(caps==false){caps=true}
                       else {caps=false}
                   }
               }
            }
            Rectangle {
               id: a
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("A"):qsTr("a")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("A"):mykeyboard.keysignal("a")
                   }
               }
            }

            Rectangle {
               id: s
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("S"):qsTr("s")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("S"):mykeyboard.keysignal("s")
                   }
               }
            }
            Rectangle {
               id: d
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("D"):qsTr("d")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("D"):mykeyboard.keysignal("d")
                   }
               }
            }
            Rectangle {
               id: f
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("F"):qsTr("f")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("F"):mykeyboard.keysignal("f")
                   }
               }
            }
            Rectangle {
               id: g
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("G"):qsTr("g")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("G"):mykeyboard.keysignal("g")
                   }
               }
            }
            Rectangle {
               id: h
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("H"):qsTr("h")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("H"):mykeyboard.keysignal("h")
                   }
               }
            }
            Rectangle {
               id: j
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("J"):qsTr("j")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("J"):mykeyboard.keysignal("j")
                   }
               }
            }
            Rectangle {
               id: k
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("K"):qsTr("k")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("K"):mykeyboard.keysignal("k")
                   }
               }
            }
            Rectangle {
               id: l
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("L"):qsTr("l")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("L"):mykeyboard.keysignal("l")
                   }
               }
            }
            Rectangle {
               id: enter
               width: 70
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("Enter")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mykeyboard.enterkey(true)
                   }


               }
            }

        }
        Row {
            id: zxc
            spacing: 10
            Rectangle {
               id: z
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("Z"):qsTr("z")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                        (caps==true)? mykeyboard.keysignal("Z"):mykeyboard.keysignal("z")
                   }
               }
            }

            Rectangle {
               id: x
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("X"):qsTr("x")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("X"):mykeyboard.keysignal("x")
                   }
               }
            }
            Rectangle {
               id: c
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("C"):qsTr("c")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("C"):mykeyboard.keysignal("c")
                   }
               }
            }
            Rectangle {
               id: v
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("V"):qsTr("v")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("V"):mykeyboard.keysignal("v")
                   }
               }
            }
            Rectangle {
               id: b
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("B"):qsTr("b")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("B"):mykeyboard.keysignal("b")
                   }
               }
            }
            Rectangle {
               id: n
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("N"):qsTr("n")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("N"):mykeyboard.keysignal("n")
                   }
               }
            }
            Rectangle {
               id: m
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: (caps==true)? qsTr("M"):qsTr("m")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       (caps==true)? mykeyboard.keysignal("M"):mykeyboard.keysignal("m")
                   }
               }
            }
            Rectangle {
               id: coma
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr(",")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mykeyboard.keysignal(",")
                   }
               }
            }
            Rectangle {
               id: punto
               width: 50
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr(".")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mykeyboard.keysignal(".")
                   }
               }
            }
            Rectangle {
               id: space
               width: 150
               height: 40
               color: "#CCCCCC"
               Button {
                   text: qsTr("Space")
                   anchors.centerIn: parent
                   anchors.fill: parent
                   onClicked: {
                       mykeyboard.keysignal(" ")
                   }
               }
            }


        }

    }

}
