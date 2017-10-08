#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include <memorialogin.h>
#include <memoriaconfig.h>
#include <keyboardlauncher.h>
#include <sensortemperatura.h>

int main(int argc, char *argv[])
{
//asdasdasd
    //Crea un nuevo tipo de elemento llamado MemoriaLogin, y hay que importarlo con "import MemoriaLoginCPP 1.0"
    qmlRegisterType <MemoriaLogin>("MemoriaLoginCPP",1,0,"MemoriaLogin");
    qmlRegisterType <MemoriaConfig>("MemoriaConfigCPP",1,0,"MemoriaConfig");
    qmlRegisterType <KeyboardLauncher>("KeyboardLauncherCPP", 1, 0, "KeyboardLauncher");
    qmlRegisterType <SensorTemperatura>("SensorTemperaturaCPP", 1, 0, "SensorTemperatura");

    SensorTemperatura sensor;   //Se crea un objeto de la clase SensorTemperatura
    sensor.Init_temperatura();  //Inicializa el sensor de temperatura


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
