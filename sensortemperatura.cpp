
#include "sensortemperatura.h"

#define LED1 21 // PIN 29 = #5
//#define PINSENSOR   25   // PIN 37 = #26
#define PINSENSOR   24   // PIN 35 = #19

SensorTemperatura::SensorTemperatura (QObject *parent) : QObject(parent)
{
}

void SensorTemperatura::Init_temperatura()
{
    wiringPiSetup();
    pinMode(LED1,OUTPUT);
    pinMode(PINSENSOR,INPUT);   //Se pone como input para que quede el bus en alto (con la pullup)
    delay(1);       //Espera 1ms
    reset();
    write(0xCC);    //Skip ROM
    write(0x4E);    //Write Scratchpad
    write(0xFF);    //TH register (trigger superior = +127C)
    write(0x81);    //TL register (trigger inferior = -127C, esta en Complemento a 2)
    write(0x1F);    //Configuration register. R0=R1=0 -> 9bits resolution
}

int SensorTemperatura::leer_temperatura()
{
    while(reset()); //Si no hubo error en el reset
    //reset();
    write(0xCC);    //Skip ROM
    write(0x44);    //Start Conversion
    wait();         //Espera a que termine de convertir
    write(0xBE);    //Read Scratchpad
    unsigned char dataLSB=read();   //Lee los dos bytes de temperatura
    unsigned char dataMSB=read();
    reset();        //Se corta la transmision del sensor

    dataLSB = dataLSB >> 4;     //Con resolucion de 9 bits, los 1ros 3 son indefinidos (y el LSB que es para los 0.5C no se usa)
    dataMSB = dataMSB & 0x07;   //Se le borran los 5 bits MSB (se supone que la temperatura siempre va a ser positiva)
    int temp = dataLSB + (dataMSB << 4);    //Se corre solo 4 porque en el LSB se desplazo 4 hacia la derecha

    digitalWrite(LED1,HIGH);
    delay(100);
    digitalWrite(LED1,LOW);
    qDebug() << temp;
    return temp;
}

int SensorTemperatura::reset()
{
    pinMode(PINSENSOR,OUTPUT);
    digitalWrite(PINSENSOR,LOW);    //Se pone la salida en cero
    delayMicroseconds(600);         //Se espera 480uS (que es el minimo)

    pinMode(PINSENSOR,INPUT);       //se suelta el bus
    delayMicroseconds(60);          //El sensor espera entre 15 y 60uS para que la linea se levante

    delayMicroseconds(40);          //Espero un poco mas por las dudas
    if(digitalRead(PINSENSOR)==0){
        //El sensor respondio bien, hay que esperar a que termine el slot de reset
        delayMicroseconds(400);     //El slot de reset es de 480uS desde que se suelta el bus
        qDebug() << "Reset OK";
        return 0;                   //Reset OK
    }
    else{
        //El sensor no respondio. Se espera lo que qeda de slot y se devuelve error
        delayMicroseconds(400);
        qDebug() << "Reset Error";
        return 1;
    }
}

void SensorTemperatura::write(unsigned char data)
{
    unsigned char aux=data;

    pinMode(PINSENSOR,OUTPUT);
    for(int i=0; i<8; i++){
        if( ( (aux >> i) & 0x01 ) == 0 ){   //se envia primero el LSB hasta llegar al MSB
            //Se escribe un cero
            digitalWrite(PINSENSOR,LOW);
            delayMicroseconds(80);      //se espera el slot Write 0
            pinMode(PINSENSOR,INPUT);   //Se suelta el bus
            delayMicroseconds(1);       //Tiempo de recuperacion del bus
        }
        else{
            //Se escribe un uno
            digitalWrite(PINSENSOR,LOW);
            delayMicroseconds(1);
            pinMode(PINSENSOR,INPUT);   //se suelta el bus
            delayMicroseconds(80);      //se espera el slot Write 1
        }
    }
}

unsigned char SensorTemperatura::read()
{
    unsigned char data=0;

    for(int i=0; i<8; i++){
        pinMode(PINSENSOR,OUTPUT);
        digitalWrite(PINSENSOR,LOW);    //Se baja el bus
        delayMicroseconds(2);           //Se espera un tiempo para leer (>1us)
        pinMode(PINSENSOR,INPUT);       //Se suelta la linea
        delayMicroseconds(10);          //Espera a leer el dato (recomienda hacerlo antes de los 15uS de bajado el bus)
        if(digitalRead(PINSENSOR)==0){
            data = data << 1;
        }
        else{
            data = (data<<1) + 1;
        }
        pinMode(PINSENSOR,INPUT);       //Se suelta el bus
        delayMicroseconds(60);          //Se espera a que se termine el slot
    }
    return data;
}

void SensorTemperatura::wait()
{
    while(1){
        pinMode(PINSENSOR,OUTPUT);
        digitalWrite(PINSENSOR,0);      //Baja el bus
        delayMicroseconds(2);           //Espera un tiempo para leer (>1us)
        pinMode(PINSENSOR,INPUT);       //Suelta el bus
        delayMicroseconds(10);          //Espera a leer el dato
        if(digitalRead(PINSENSOR)==1){
            return;                     //Si la respuesta es 1 significa que termino la conversion, sino se espera al siguiente slot para leer.
        }
        pinMode(PINSENSOR,INPUT);       //Se suelta el bus
        delayMicroseconds(60);          //Se espera a que se termine el slot
    }
}
