import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0

import KeyboardLauncherCPP 1.0  //Importa el nuevo elemento para tener acceso a keyboardlauncher.cpp

import MemoriaLoginCPP 1.0      //Importa el nuevo elemento para tener acceso a memorialogin.cpp

/* Esta ventana muestra todos los elementos para el login, encargándose ademas de cargar los usuarios guardados y
 verificar que la contraseña sea correcta */


Page {

    id: tablogin
    signal signaluser_ventanalogin(real currentuser)     //Senal propia de VentanaLogin.qml. Currentuser se modifica con el boton de login
    onSignaluser_ventanalogin: instanciaventanaconfig.signaluser_config(currentuser)    //Cuando signaluser() se modifique, va a poner currentuser en la senal signaluser_config (creada en la instanciaventanaconfig)
    //Camino de senales: VentanaLogin->instanciaventanaconfig->VentanaConfig->instanciacambiarpass->VentanaCambiarPass
    signal loginsignal (int loginstate)    //Senal para saber cuando mostrar/ocultar todos los objetos de VentanaLogin y VentanaConfig
    onLoginsignal: {
        //console.log("loginsignal")
        instanciakeyboardanimator.running = true
        columnaloginanimator.running = true
    }





    //signal signalkeyboard(bool key)

    Keyboard {
        id: instanciakeyboard
        visible: true               //De entrada esta visible el teclado
        anchors.verticalCenter: parent.verticalCenter
        onKeysignal: {
            //console.log("keysignal")
            passinput.text += keysend          //Cuando keysignal() cambie, va a poner su contenido (string keysend) en passinput
        }
        onBackspacekey: passinput.remove(passinput.length-1,passinput.length)   //Cuando se active backspacekey() en Keyboard.qml va a eliminar el text de passinput desde length-1 hasta length
        onEnterkey: {
            //console.log("entersignal")
            loginbutton.checked = true           //Cuando se active la senal dentro de Keyboard.qml va a presionar (y sostener) el boton loginbutton
        }
    }
    OpacityAnimator {       //Animacion para mostrar/ocultar el keyboard
        id: instanciakeyboardanimator
        target: instanciakeyboard
        from: (loginsignal.loginstate!==0)? 1:0        //No se porque me pide === o !==
        to: (loginsignal.loginstate!==0)? 0:1
        duration: 500
        running: false
    }



    //Creo una instancia de MemoriaLogin para tener acceso a la clase memorialogin.cpp
    MemoriaLogin {
        id: memlogin
    }



    Column {
        id: columnalogin
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        y: -200

        Text{
            id:logintext
            text: "LOGIN"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Tahoma"
            color: "#a99f9f"
            anchors.horizontalCenter: parent.horizontalCenter

        }
        Row {    //Columnas para organizar User/Passwordn y ComboBox/Textfield
            spacing: 10
            Column {
                spacing: 40
                Text{
                    text: qsTr("User")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Tahoma"
                    color: "#a99f9f"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: qsTr("Password")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Tahoma"
                    color: "#a99f9f"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column {
                spacing: 20
                ComboBox {
                    id: users
                    model: [memlogin.get_user(0),memlogin.get_user(1),memlogin.get_user(2),memlogin.get_user(3),memlogin.get_user(4)]
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                TextField {
                    id: passinput
                    width: 250
                    text: qsTr("")
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    focus: true
                    echoMode: TextInput.Password
                    //Esta condicion se usa cuando se presiona el Enter (pero aca ya no tenemos teclas, y el keyboard no la simula)
//                    Keys.onReturnPressed: {
//                        if(memlogin.login_input(users.currentIndex,passinput.text)){
//                            tabBar.currentIndex = 2     //Cambia la pestaña del swipeView
//                            passinput.text = ""         //Borra el contenido de la pass
//                        }
//                        else{
//                            passinput.text = ""
//                        }
//                    }
                }//Textfield
            }//Column
        }//Row


        Button {
            id: loginbutton
            height: 40
            width: 100
            text: "Login"
            font.pointSize: 10
//            font.family: "Courier"
            spacing: 0
            //Material.accent: "#004D40"
            anchors.horizontalCenter: parent.horizontalCenter
            checkable: true         //Tiene que ser checkeable por senales externas (keysend)
            onCheckedChanged: {     //Cuando cambia de check=false a true (o viceversa):
                if(loginbutton.checked == true){    //El cambio fue de true a false?
                    console.log(passinput.text)
                    if(memlogin.login_input(users.currentIndex,passinput.text)){
                        passinput.text = ""         //Borra el contenido de la pass
                        tablogin.signaluser_ventanalogin(users.currentIndex)         //Se pone el numero de user en la senal. Esta despues tiene que conectarse con VentanaConfig y despues con VentanaCambiarPass
//                        columnalogin.visible = false    //Oculta las cosas de ventanalogin
//                        instanciakeyboard.visible = false //Oculta el keyboard
//                        instanciaventanaconfig.visible = true   //Muestra la ventana config
//                        mytabBar.visible = false              //Oculta la barra de pestanas
                        console.log("login OK")
                        tablogin.loginsignal(1)              //Se activa la senal con un 1 para avisar que hubo login correcto

                    }
                    else{
                        passinput.text = ""     //Borra la pass para indicar que es incorrecta (no se si es necesario usar colores o msjs)
                    }
                }
                loginbutton.checked = false     //Vuelve de nuevo a false. Este cambio tambien genera un onCheckedChanged, por eso se puso el if arriba
            }



        }
    }
    OpacityAnimator {       //Animacion para mostrar/ocultar la columnalogin
        id: columnaloginanimator
        target: columnalogin
        from: (loginsignal.loginstate!==0)? 1:0
        to: (loginsignal.loginstate!==0)? 0:1
        duration: 500
        running: false
    }
}
