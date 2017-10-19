
#include "sensortemperatura.h"

#define LED1 21 // PIN 29 = #5
#define PINSENSOR   25   // PIN 37 = #26
//#define PINSENSOR   24   // PIN 35 = #19

SensorTemperatura::SensorTemperatura (QObject *parent) : QObject(parent)
{
}



float SensorTemperatura::leer_temperatura()
{
    QFile file("/sys/bus/w1/devices/10-00080233bd31/w1_slave");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return 0;

    QTextStream in(&file);
    QString line;
    line = in.readLine();   //lee la primera linea del archivo (que termina en crc=XX YES)
    line = in.readLine();   //Lee la segunda linea, que termina en la temperatura
    QString tempstring=line.right(5); //Guarda en temp los 5 digitos de mas a la derecha de line
    float temp = tempstring.toFloat();
    //qDebug() << temp/1000;
    return temp/1000;

}

