#ifndef SENSORTEMPERATURA_H
#define SENSORTEMPERATURA_H

#include <wiringPi.h>       //para que funcione en cross-compiling hay que hacer el clone+build en RPi y copiar el .so a [ubuntu]/usr/local/lib
#include <QObject>
#include <QDebug>
#include <QPoint>
#include <QFile>

class SensorTemperatura : public QObject
{
    Q_OBJECT
public:
    explicit SensorTemperatura(QObject *parent = nullptr);

    Q_INVOKABLE float leer_temperatura();

private:

signals:

public slots:
};

#endif // SENSORTEMPERATURA_H
