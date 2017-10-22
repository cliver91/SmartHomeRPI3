import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

import KeyboardLauncherCPP 1.0  //Importa el nuevo elemento para tener acceso a keyboardlauncher.cpp
import MemoriaLoginCPP 1.0      //Importa el nuevo elemento para tener acceso a memorialogin.cpp
import MemoriaConfigCPP 1.0      //Importa el nuevo elemento para tener acceso a memoriaconfig.cpp



/* Esta ventana muestra todas las posibles configuraciones de la alarma */
Page {
    id: tabconfig

    signal signaluser_ventanaconfig(real user_config)  //Senal propia de VentanaConfig.qml. Lo que llegue a esta senal viene de VentanaLogin.qml
    onSignaluser_ventanaconfig: instanciacambiarpass.signaluser_cambiopass(user_config) //Cuando signaluser_config se modifique, va a poner currentuser_config en la senal signaluser_cambiopass (creada en la instanciacambiarpass)
    //Camino de senales: VentanaLogin->instanciaventanaconfig->VentanaConfig->instanciacambiarpass->VentanaCambiarPass

    signal configsignal (int configstate)   //0=config, 1=cambiarpass, 2=cambiartelef, 3=guardar. El onoff es para hacer aparecer o desaparecer los objetos
    onConfigsignal: {
        if(configstate===0){
            console.log("configstate=0")
            frame_superioranimator.running = true       //Si es config significa que se volvio desde cambiarpass. La variable configstate les va a decir a los animators si tienen que aparecer o desaparecer
            frame_inferioranimator.running = true
            instanciacambiarpassanimator.running = true
        }
        if(configstate===1){
            console.log("configstate=1")
            frame_superioranimator.running = true       //Si es cambiarpass hay que sacar las dos. La variable configstate les va a decir a los animators si tienen que aparecer o desaparecer
            frame_inferioranimator.running = true
            instanciacambiarpassanimator.running = true
        }
        if(configstate===2){
            console.log("configstate=2")
            instancianumpadanimator.running = true      //Si es cambiartelefono hay que sacar el frame_inferior y poner el numpad. Los animators van a saber si aparecen o desaparecen con la variable configstate
            frame_inferioranimator.running = true
        }
        if(configstate===3){
            console.log("configstate=3")
            frame_superioranimator.running = true       //Idem al if anterior
            frame_inferioranimator.running = true
            //loginsignal(0)          //activa la senal para que en ventanalogin vuelva a aparecer la columnalogin, tabbar, etc.
        }
    }


    MemoriaConfig {
            id: memconfig
    }
    Numpad {
        id:instancianumpad
        anchors.horizontalCenter: parent.horizontalCenter
        y:140
        visible: true
        opacity: 0
        onNumkey: textField_telefono.text += numkeysend //Cuando cambie la senal numkey (dentro de Numpad.qml), va a agregar su contenido (numkeysend) al textField_telefono
        onNumbackspacekey: textField_telefono.remove(textField_telefono.length-1,textField_telefono.length) //Idem a las aclaraciones en Keyboard.qml
    }
    OpacityAnimator {
        id: instancianumpadanimator
        target: instancianumpad
        from: (configsignal.loginstate===2)? 0:1;        //Si el estado es config se muestra/oculta
        to: (configsignal.loginstate===2)? 1:0;
        duration: 500
        running: false
    }

    VentanaCambiarPass {
        id: instanciacambiarpass
        anchors.centerIn: parent
        visible: true
        opacity: 0
        signal signaluser_cambiopass(real user_cambiopass)  //Senal propia de la INSTANCIA de VentanaCambiarPass
        onSignaluser_cambiopass: {
            signaluser_config.connect(signaluser_ventanacambiarpass)        //Cuando cambie signaluser_cambiopass (propia de la INSTANCIA de VentanaCambiarPass) se va a conectar con signaluser_ventanacambiarpass (propia de VentanaCambiarPass.qml)
        }
    }
    OpacityAnimator {
        id: instanciacambiarpassanimator
        target: instanciacambiarpass
        from: (configsignal.configstate===1)? 1:0        //Si el estado es cambiarpass se muestra/oculta
        to: (configsignal.configstate===1)? 0:1
        duration: 500
        running: false
    }

    Frame {
        id: frame_superior      //Este frame tiene los controles de celular y cambiar contrasena
        width: parent.width
        height: parent.height/2
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.centerIn: parent

        Button {
            id: button_cambiar_pass
            x: 180
            y: -220
            width: 150
            height: 50
            text: qsTr("Cambiar")
            onPressed: {
//                frame_superior.visible = false      //Oculta toda la info de VentanaConfig
//                frame_inferior.visible = false
                //instanciaventanaconfig.visible = false
                //De aca se va a VentanaCambiarPass
                //instanciacambiarpass.visible = true //Muestra la ventana VentanaCambiarPass
                configsignal(1)     //Cambia la senal para hacer aparecer VentanaCambiarPass.
            }
        }

        Label {
            id: label_contrasena
            x: -400
            y: -200
            text: qsTr("Contraseña")
            font.pointSize: 17
        }

        Switch {
            id: switch_avisar
            x: 220
            y: -155
        }

        Label {
            id: label_avisar
            x: -400
            y: -150
            width: 339
            height: 34
            text: qsTr("Avisar a los otros usuarios (SMS)")
            font.pointSize: 17
        }


        Button {
            id: button_cambiar_tel
            x: 180
            y: -110
            width: 150
            height: 50
            text: qsTr("Cambiar")
            onClicked: {
                if(button_cambiar_tel.text=="Cambiar"){ //Si cuando se aprieta es para cambiar
                    text = qsTr("Aceptar")              //Cambia el texto del boton
                    textField_telefono.text = ""        //Limpia el antiguo numero
                    configsignal(2)                     //Se activa la senal para decir que se esta ahora en cambiotelefono
//                    frame_inferior.visible = false      //Oculta toda la parte inferior
//                    instancianumpad.visible = true      //Hace visible el teclado
                }
                else{                                   //Si ya esta cambiando y quiere aceptar
                    text = qsTr("Cambiar")              //Vuelve al texto original
                    configsignal(0)                     //Se activa la senal para volver al estado config
//                    frame_inferior.visible = true       //Vuelve a aparecer los controles de abajo
//                    instancianumpad.visible = false     //Oculta el teclado
                }
            }

        }

        TextField {
            id: textField_telefono
            x: -150
            y: -110
            width: 259
            height: 51
            text: qsTr("+5492994519498")
            font.pointSize: 17
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: label_nro_tel
            x: -400
            y: -100
            text: qsTr("N° de teléfono:")
            font.pointSize: 17
        }
    }
    OpacityAnimator {
        id: frame_superioranimator
        target: frame_superior
        from: (configsignal.configstate===1 || configsignal.configstate===3)? 0:1        //Si el estado es cambiarpass o guardar se oculta/muestra
        to: (configsignal.configstate===1 || configsignal.configstate===3)? 1:0
        duration: 500
        running: false
    }
    Frame {
        id: frame_inferior          //Este frame tiene todos los controles de tiempo de entrada y salida
        width: parent.width
        height: parent.height/2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: frame_superior.bottom
        //anchors.centerIn: parent

        Label {
            id: label_seg_salida
            x: 260
            y: 120
            width: 25
            height: 12
            text: qsTr("seg.")
            font.pointSize: 17
        }

        Label {
            property real valordial: (dial_salida.value).toFixed(0)   //defino la propiedad para poder poner el valor del dial como texto
            id: label_t_salida
            x: 220
            y: 120
            text: valordial
            font.pointSize: 17
        }

        Label {
            property real valordial: (dial_entrada.value).toFixed(0)   //defino la propiedad para poder poner el valor del dial como texto
            id: label_t_entrada
            x: 220
            y: 10
            text: valordial
            font.pointSize: 17
        }

        Label {
            id: label_seg_entrada
            x: 260
            y: 10
            text: qsTr("seg.")
            font.pointSize: 17
        }

        Dial {
            id: dial_salida
            x: 40
            y: 90
            width: 100
            height: 100
            from: 10
            to: 30
            stepSize: 1
        }

        Dial {
            id: dial_entrada
            x: 40
            y: -30
            height: 100
            width: 100
            from: 10
            to: 30
            stepSize: 1

        }

        Label {
            id: label_salida
            x: -400
            y: 120
            text: qsTr("Tiempo de espera (a la salida)")
            font.pointSize: 17
        }

        Label {
            id: label_entrada
            x: -400
            y: 0
            text: qsTr("Tiempo de disparo (a la entrada)")
            font.pointSize: 17
        }

        Button {
            id: guardarconfig
            x:180
            y:200
            width: 160
            height: 50
            text: qsTr("Guardar")
            onPressed: {
                //Aca hay que guardar todas las variables con C++!


                //mytabBar.currentIndex = 0 //Vuelve a la pantalla principal
                configsignal(3)       //Se esta ahora en estado 3, con el off se les dice a los frame_inf/sup que se oculten
//                mytabBar.visible = true   //Barra de vuelta visible
//                instanciaventanaconfig.visible = false //Oculta todos los objetos de configuracion
//                columnalogin.visible = true //Vuelve a poner visible la ventana login
//                instanciakeyboard.visible = true    //idem anterior


            }
        }
    }
    OpacityAnimator {
        id: frame_inferioranimator
        target: frame_inferior
        from: (configsignal.configstate>0)? 0:1//(configsignal.configstate>0)? 1:0        //Si el estado es cambiarpass, cambiartelefono o guardar se oculta. Sino se muestra
        to: (configsignal.configstate>0)? 1:0
        duration: 500
        running: false
    }
}
