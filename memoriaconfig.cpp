#include "memoriaconfig.h"

MemoriaConfig::MemoriaConfig(QObject *parent) : QObject(parent)
{

}

void MemoriaConfig::cargar_config(int user_number)
{
    //Hay que acceder a la direccion de la memoria en funcion de user_number
}

void MemoriaConfig::guardar_config(int user_number)
{
    //Hay que acceder a la direccion de la memoria en funcion de user_number
}

int MemoriaConfig::cambiar_pass(int user_number,QString oldpass, QString newpass, QString confirm)
{
    //Hay que acceder a la direccion de la memoria en funcion de user_number
    qDebug() << user_number;
    if(oldpass==passes[user_number]){
        if(newpass==confirm){
            //Reemplazar la vieja pass por la nueva en la memoria
            passes[user_number]=newpass;
            return 0;       //No hubieron errores
        }
        else{
            return 1;       //Error de confirmacion
        }
    }
    else{
        return 2;       //Error en la oldpass
    }
}

void MemoriaConfig::cambiar_telefono(int user_number, QString newcell)
{
    //Hay que acceder a la direccion de la memoria en funcion de user_number
}
