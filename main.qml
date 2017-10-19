import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

import SensorTemperaturaCPP 1.0

ApplicationWindow {
    id: mainwindow
    visible: true
    width: 720
    height: 480
    title: qsTr("Smart Home")

    signal currenttabsignal (int current)       //Esta senal se activa cada vez que se modifica mytabBar.currentindex
    onCurrenttabsignal: {
        if(current!==2){
            clockanimator.running = true        //Cuando hubo un cambio de tabs se inician las dos transiciones (una se prende y otra se apaga)

            instanciaventanalogin.visible = true    //Primero se hace visible antes de hacerlo aparecer (no se define como visible para que no se superponga con nada)
            loginanimator.running = true
            console.log("current!=2")
        }
        if(current===2){        //Si es igual a 2 significa que esta en config
            console.log("current=2")
            mytabBaranimator.running = true
            mytabBar.visible = false
        }
    }



////////////////////////////////   INSTANCIACIONES   ////////////////////////////////


        Page {      //Index 1
            anchors.fill: parent
            anchors.centerIn: parent
            VentanaLogin {
                id: instanciaventanalogin
                visible: false      //No se pone visible para que no se superponga con lo que haya en la mainwindow
                opacity: 0          //Se le pone opacidad 0 en lugar de visibilidad 0 para poder hacerlo aparecer con OpacityAnimator
                x: mainwindow.width /2
                y: mainwindow.height /2 - 30

                onLoginsignal: {

                    if(loginsignal.loginstate!==1) {
                        currenttabsignal(2)      //Si loginstate es 1 significa que se logeo correctamente, asi que le manda la senal con el 2 para activar el mytabBaranimator
                    }
                    else {
                        currenttabsignal(0)
                    }
                }
            }
            OpacityAnimator {       //Animacion para mostrar/ocultar la VentanaLogin
                id: loginanimator
                target: instanciaventanalogin;
                from: (mytabBar.currentIndex==1)? 0:1;
                to: (mytabBar.currentIndex==1)? 1:0;
                duration: 500
                running: false
            }
        }

    Clock {
        id:clock
        anchors.top: parent.top
        anchors.left: parent.left
        //visible: (mytabBar.currentIndex==0)? true:false   //Solo visible si el currentindex es 0
    }
    OpacityAnimator {       //Animacion para mostrar/ocultar el Clock
        id: clockanimator
        target: clock
        from: (mytabBar.currentIndex==0)? 0:1;
        to: (mytabBar.currentIndex==0)? 1:0;
        duration: 500
        running: false
    }

    SensorTemperatura { //Crea una instancia para que pueda llamar a las funciones de SensorTemperatura
        id:sensor
    }

////////////////////////////////   FIN INSTANCIACIONES   ////////////////////////////////

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            temptext.text = sensor.leer_temperatura().toFixed(1) + "°C";    //El toFixed trunca el float a un decimal
        }
    }

    Text {
        id: temptext
        text: "--°C"
        visible: true
        color: "white"
        font.pointSize: 26
        anchors.right: parent.right
    }

    footer: TabBar {
        id: mytabBar
        spacing: 100

        TabButton {
            id: tabPrincipal
            text: qsTr("Principal")
            width: parent.width /2
            onClicked: {
                tabPrincipal.enabled = false        //Deshabilita el tab principal para que no se apriete y active las animaciones
                tabconfig.enabled = true            //Habilita el otro porque en otra ocasion lo deshabilitamos
                tabPrincipal.text = "Principal"
                mainwindow.currenttabsignal(mytabBar.currentIndex)
            }
        }
        TabButton {
            id: tabconfig
            text: qsTr("Configuración")
            width: parent.width /2
            onClicked: {
                tabPrincipal.enabled = true         //Idem a tabprincipal
                tabconfig.enabled = false
                tabPrincipal.text = "Volver"
                mainwindow.currenttabsignal(mytabBar.currentIndex)
            }
        }
    }
    OpacityAnimator {           //Animacion para ocultar/mostrar la tabBar cuando se logea un usuario
        id: mytabBaranimator
        target: mytabBar
        from: (currenttabsignal.current===2)? 0:1
        to:(currenttabsignal.current===2)? 1:0
        duration: 500
        running: false
    }

}
