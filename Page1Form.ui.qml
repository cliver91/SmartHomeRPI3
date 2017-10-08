import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0

Item {
    property alias textField1: textField1
    property alias button1: button1
    property alias button: button

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top

        TextField {
            id: textField1
            placeholderText: qsTr("Text Field")
        }

        Button {
            id: button1
            text: qsTr("Press Me")
        }
    }

    Switch {
        id: switch1
        x: 145
        y: 146
        width: 141
        height: 34
        text: qsTr("Switch")
    }

    Dial {
        id: dial
        x: 319
        y: 110
        width: 158
        height: 149
    }

    Button {
        id: button
        x: 255
        y: 265
        width: 203
        height: 74
        text: qsTr("Button_ok")
        spacing: -3
    }
}
