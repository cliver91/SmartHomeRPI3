#include "memorialogin.h"

MemoriaLogin::MemoriaLogin(QObject *parent) : QObject(parent)
{

}

void MemoriaLogin::test()
{
    qDebug() << "Hello";
    //return 0;
}

//Verifica el user y la contraseña. Si la contrasena corresponde al user devuelve un 1
int MemoriaLogin::login_input(int user_number,QString pass)
{
    //qDebug() << user;
    qDebug() << pass;
    if(pass==passes[user_number]){
        qDebug() << "OK";
        return 1;
    }
    else{
        qDebug() << "Error";
        return 0;
    }

}

//Devuelve el string del componente numero del vector nombres
QString MemoriaLogin::get_user(int numero)
{
    if(nombres[numero]!="\0")
        return nombres[numero];
    else
        return 0;
}

int MemoriaLogin::get_user_num()
{
    int x=0;
    while(nombres[x]!="\0"){ x++; }
    return x;
}




