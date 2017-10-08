
#include "sensortemperatura.h"

#define LED1 21 // PIN 29 = #5


SensorTemperatura::SensorTemperatura (QObject *parent) : QObject(parent)
{
}

void SensorTemperatura::Init_temperatura()
{
    wiringPiSetup();
    pinMode(LED1,OUTPUT);
}

int SensorTemperatura::leer_temperatura()
{
    digitalWrite(LED1,HIGH);
    delay(500);
    digitalWrite(LED1,LOW);
    return 0;
}
