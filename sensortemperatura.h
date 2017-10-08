#ifndef SENSORTEMPERATURA_H
#define SENSORTEMPERATURA_H

#include <wiringPi.h>       //para que funcione en cross-compiling hay que hacer el clone+build en RPi y copiar el .so a [ubuntu]/usr/local/lib
#include <QObject>
#include <QDebug>
#include <QPoint>

class SensorTemperatura : public QObject
{
    Q_OBJECT
public:
    explicit SensorTemperatura(QObject *parent = nullptr);

    Q_INVOKABLE void Init_temperatura();
    Q_INVOKABLE int leer_temperatura();

private:
    int reset();
    void write(unsigned char data);
    unsigned char read();
    void wait();

signals:

public slots:
};

#endif // SENSORTEMPERATURA_H
