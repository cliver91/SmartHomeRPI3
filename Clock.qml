import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

Item {

    property int hours
    property int minutes
    property int seconds
    property string hora
    property string fecha
    property string dia


    function timeChanged() {
        var date = new Date;
        switch(date.getDay()){
            case 0: clock.dia = "Domingo";break
            case 1: clock.dia = "Lunes";break
            case 2: clock.dia = "Martes";break
            case 3: clock.dia = "Miércoles";break
            case 4: clock.dia = "Jueves";break
            case 5: clock.dia = "Viernes";break
            case 6: clock.dia = "Sábado";break
        }

        fecha = Qt.formatDateTime(date,"dd/MM" )
        hora = Qt.formatDateTime(date, "hh:mm:ss")
        hours = date.getHours()
        minutes = date.getMinutes()
        seconds = date.getSeconds()
    }



    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }
    Item {
        anchors.centerIn: parent
        width: 200; height: 240

        Rectangle {
            anchors.centerIn: parent
            Label {
                id: labelfecha
                text: clock.dia + " " + clock.fecha
                font.pointSize: 26
            }
            Label {
                id: labelhora
                text: clock.hora
                font.pointSize: 40;
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: labelfecha.left
                anchors.top: labelfecha.bottom
            }
            Label {
                id: labelprueba
                text: clock.hora
                font.pointSize: 40;
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: labelfecha.left
                anchors.top: labelfecha.bottom

            }
        }
    }
}
