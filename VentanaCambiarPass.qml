import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

import MemoriaConfigCPP 1.0      //Importa el nuevo elemento para tener acceso a memoriaconfig.cpp

//Este archivo es llamado unicamente por VentanaConfig

Page {
    id: tabcambiopass

    property real estado : 0        //Estado representa el estado en el que se encuetra el cambio: antiguapass, nuevapass o confirmacionnuevapass
    property real user: 0           //Variable que representa el numero de user que se logeo en VentanaLogin
    property string mystring: ""    //String para recibir datos de Keyboard
    property string mystring_ant: ""    //String para guardar momentaneamente la vieja contrasena
    property string mystring_nue: ""    //String para guardar momentaneamente la nueva contrasena

//    signal keysignal (string keysend)
//    onKeysignal: mystring=keysend

    signal signaluser_ventanacambiarpass (real user_cambiopass)     //Senal propia de VentanaCambiarPass.qml
    onSignaluser_ventanacambiarpass: user = user_cambiopass         //cuando signaluser_ventanacambiarpass cambie, va a poner su argumento en "user"
    //Camino de senales: VentanaLogin->instanciaventanaconfig->VentanaConfig->instanciacambiarpass->VentanaCambiarPass


    Keyboard {
        id: cambiopasskeyboard
        visible: true               //De entrada esta visible el teclado
        anchors.verticalCenter: parent.verticalCenter
        onEnterkey: siguientepassbutton.checked = true           //Cuando se active la senal dentro de Keyboard.qml va a presionar (y sostener) el boton loginbutton
        onKeysignal: cambiopassinput.text += keysend            //Cada vez que la senal cambie, va a agregar el caracter que contenga en el textfield
        onBackspacekey: cambiopassinput.remove(cambiopassinput.length-1,cambiopassinput.length)   //Cuando se active backspacekey() en Keyboard.qml va a eliminar el text de passinput desde length-1 hasta length
    }

    Label {
        id: titulocambiopass
        text: qsTr("Antigua contraseña")
        anchors.horizontalCenter: parent.horizontalCenter
        y: -120
        font.pointSize: 17
    }
    TextField {
        id: cambiopassinput
        width: 250
        text: qsTr("")
        anchors.horizontalCenter: parent.horizontalCenter
        y: -70

        horizontalAlignment: Text.AlignHCenter
        focus: true
        echoMode: TextInput.Password

    }

    Button {
        id: siguientepassbutton
        x: 200
        y: -70
        checkable: true
        text: qsTr("Siguiente")
        onCheckedChanged: {     //Cuando cambia de check=false a true (o viceversa):
            if(siguientepassbutton.checked == true){    //El cambio fue de true a false?
                switch (estado){
                case 0: //Ingresar antigua pass
                    if(memlogin.login_input(users.currentIndex,cambiopassinput.text)){
                        estado+=1                           //Se paso la primera etapa
                        mystring_ant = cambiopassinput.text
                        cambiopassinput.text = ""           //Borra el contenido de la pass
                        titulocambiopass.text = "Nueva contraseña"      // \u00F1=0x00F1= n~
                    }
                    else{
                        cambiopassinput.text = ""     //Borra la pass para indicar que es incorrecta (no se si es necesario usar colores o msjs)
                        //Ver como poner un msj de contrasena incorrecta
                    }
                    break
                case 1: //Ingresar nueva pass
                    estado+=1
                    mystring_nue = cambiopassinput.text
                    cambiopassinput.text = ""
                    titulocambiopass.text = "Confirme contraseña"      // \u00F1=0x00F1= n~
                    break
                case 2:
                    if(cambiopassinput.text == mystring_nue){
                        memconfig.cambiar_pass(users.currentIndex,mystring_ant,mystring_nue,mystring_nue)
                        estado=0
                        cambiopassinput.text=""     //Borra igualmente el textfield
                        titulocambiopass.text = "Antigua contraseña"    //Deja la ventana en el estado inicial
//                        instanciacambiarpass.visible = false //Oculta todos los objetos de cambiopass
//                        frame_inferior.visible = true
//                        frame_superior.visible = true
                        configsignal(0)     //Se activa la senal para que en VentanaConfig se desaparezca Cambiarpass y aparezcan los frames
                    }
                    else{
                        cambiopassinput.text=""
                        //Ver como poner un msj de contrasena incorrecta
                    }
                }//switch
            }//if
            siguientepassbutton.checked = false     //Vuelve de nuevo a false. Este cambio tambien genera un onCheckedChanged, por eso se puso el if arriba
        }//onCheckedChanged
    }
    Button {
        id: button_cambiarpass_cancelar
        x: 192          //Se pusieron estas coordenadas para que coincidiera con button_cambiar_pass
        y: -208
        width: 150
        height: 50
        text: qsTr("Cancelar")
        onPressed: {
            cambiopassinput.text = ""           //Borra por si escribieron algo antes de cancelar
            estado = 0                          //Se vuelve al estado inicial para la proxima vez que se quiera cambiar la pass
            titulocambiopass.text = "Antigua contraseña"      // \u00F1=0x00F1= n~
//            frame_superior.visible = true      //Vuelve a VentanaConfig
//            frame_inferior.visible = true
//            instanciacambiarpass.visible = false //Oculta la ventana VentanaCambiarPass
            configsignal(0)             //Se activa la senal para volver a la pantalla VentanaConfig
        }
    }


}
