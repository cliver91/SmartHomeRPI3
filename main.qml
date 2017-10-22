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



    property int current: 0     //Hice esta variable porque no se como leer el argumento de la senal dentro de los objetos
    property int onoff: 0       //Se define como 1 o 0 si se quiere que las animaciones se prendan o apaguen
    signal currenttabsignal (int currenttab, int anterior)       //Esta senal se activa cada vez que se modifica mytabBar.currentindex

    onCurrenttabsignal: {
        if(currenttab===0){
            buttonconfig.on = false         //Se define el boton como no presionado (por si se vuelve a la pantalla main sin haber presionado el boton)
            onoff = 1                       //Se van a prender las animaciones de clock y temp
            clockanimator.running = true
            tempanimator.running = true
            if(anterior===1){               //Si el estado anterior fue VentanaLogin hay que ocultar el teclado
//                onoff=0                     //Se va a ocultar el teclado
//                loginanimator.running = true
                //instanciaventanalogin.visible = false
            }
            else if(anterior===2){
                //La animation de ocultar VentanaConfig ya se hace dentro de VentanaConfig
                instanciaventanaconfig.visible = false  //Se oculta la instancia
            }

            console.log("current = 0")
        }
        if(currenttab===1){
            buttonconfig.on = true          //El boton se presiono (esto es por si se llega a VentanaLogin sin haber presionado el boton)

            onoff = 1
            instanciaventanalogin.visible = true    //Se hace visible (se habia hecho no visible para que no joda con la pantalla principal)
            loginanimator.running = true    //Se enciende el teclado
            //instanciaventanalogin.loginsignalmain(1)

            onoff = 0
            clockanimator.running = true    //Se apagan el reloj y temp
            tempanimator.running = true

            instanciaventanaconfig.visible = false

            console.log("current = 1")
        }

        if(currenttab===2){        //Si es igual a 2 significa que esta en config
            //loginsignalmain(1)      //Se levanta la bandera para avisar a ventanaconfig animator
            onoff = 0
//            loginanimator.running = true    //Se oculta la VentanaLogin
            instanciaventanalogin.loginsignalmain(0)
            instanciaventanalogin.visible = false

            onoff = 1
            instanciaventanaconfig.visible = true       //Se pone visible antes de hacerlo aparecer
            instanciaventanaconfiganimator.running = true

            console.log("current = 2")
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

                    if(loginstate===1) {
                        instanciaventanalogin.visible = false
                        instanciaventanalogin.opacity = 0
                        currenttabsignal(2,1)      //Si loginstate es 1 significa que se logeo correctamente, asi que le manda la senal con el 2 para activar el mytabBaranimator
                    }
                }
                signal loginsignalmain (int val)            //Senal para conectar ventanalogin con ventanaconfig animator
                onLoginsignalmain: {
                    loginsignalmain.connect(loginsignal)        //Cuando cambie loginsignalmain (propia de la INSTANCIA de VentanaLogin) se va a conectar con loginsignal (propia de VentanaLogin)
                }
            }
            OpacityAnimator {       //Animacion para mostrar/ocultar la VentanaLogin
                id: loginanimator
                target: instanciaventanalogin;
                from: (onoff===1)? 0:1
                to: (onoff===1)? 1:0
                duration: 500
                running: false
            }
        }

        Page {
            VentanaConfig {
                id: instanciaventanaconfig
                visible: false      //No se tiene que poner visible porque se superpone sobre el teclado y no lo deja usar!
                opacity: 0          //Se le pone opacidad 0 en lugar de visibilidad 0 para poder hacerlo aparecer con OpacityAnimator
                x: mainwindow.width /2
                y: mainwindow.height /2 - 30
                signal signaluser_config (real user_config)     //senal propia de la INSTANCIA de VentanaConfig
                onSignaluser_config: {
                    signaluser_config.connect(signaluser_ventanaconfig) //Cuando cambia la senal signaluser_config (propia de esta INSTANCIA), la va a conectar con la senal signaluser_ventanaconfig (propia de VentanaConfig.qml)
                }
                onConfigsignal: {
                    if(configstate===3){
                        currenttabsignal(0,2)         //Se avisa que se cambio el indice


                    }
                }
            }
            OpacityAnimator {       //Animacion para mostrar/ocultar La VentanaConfig
                id: instanciaventanaconfiganimator
                target: instanciaventanaconfig
                from: (onoff===1)? 0:1;
                to: (onoff===1)? 1:0;
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
        from: onoff===1? 0:1
        to: onoff===1? 1:0
        duration: 500
        running: false
    }

    SensorTemperatura { //Crea una instancia para que pueda llamar a las funciones de SensorTemperatura
        id:sensor
    }

////////////////////////////////   FIN INSTANCIACIONES   ////////////////////////////////

    Timer {
        id: maintimer
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
    OpacityAnimator {
        id: tempanimator
        target: temptext
        from: onoff===1? 0:1
        to: onoff===1? 1:0
        duration: 500
        running: false
    }

    Button {
        id: buttonconfig
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 120
        height: 50
        property bool on: false
        onClicked: {
            if(on===false){
                on = true
                currenttabsignal(1,0)
            }
            else if(on===true){
                on = false
                currenttabsignal(0,1)
            }


//            if(current===0){
//                current=1
//                currenttabsignal(current)     //Da la senal para los animators
//                console.log(current)
//            }
//            else if(current===1){
//                current=0
//                currenttabsignal(current)     //Da la senal para los animators
//                console.log(current)
//            }
        }

    }

//    footer: TabBar {
//        id: mytabBar
//        spacing: 100

//        TabButton {
//            id: tabPrincipal
//            text: qsTr("Principal")
//            width: parent.width /2
//            onClicked: {
//                tabPrincipal.enabled = false        //Deshabilita el tab principal para que no se apriete y active las animaciones
//                tabconfig.enabled = true            //Habilita el otro porque en otra ocasion lo deshabilitamos
//                tabPrincipal.text = "Principal"
//                mainwindow.currenttabsignal(mytabBar.currentIndex)
//            }
//        }
//        TabButton {
//            id: tabconfig
//            text: qsTr("Configuración")
//            width: parent.width /2
//            onClicked: {
//                tabPrincipal.enabled = true         //Idem a tabprincipal
//                tabconfig.enabled = false
//                tabPrincipal.text = "Volver"
//                mainwindow.currenttabsignal(mytabBar.currentIndex)
//            }
//        }
//    }
//    OpacityAnimator {           //Animacion para ocultar/mostrar la tabBar cuando se logea un usuario
//        id: mytabBaranimator
//        target: mytabBar
//        from: (mytabBar.currentIndex===2)? 0:1
//        to:(mytabBar.currentIndex===2)? 1:0
//        duration: 500
//        running: false
//    }

}
