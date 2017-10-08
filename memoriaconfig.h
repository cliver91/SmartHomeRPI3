#ifndef MEMORIACONFIG_H
#define MEMORIACONFIG_H

#include <QObject>
#include <QDebug>
#include <QPoint>


class MemoriaConfig : public QObject
{
    Q_OBJECT
public:
    explicit MemoriaConfig(QObject *parent = nullptr);

    Q_INVOKABLE void cargar_config(int user_number);
    Q_INVOKABLE void guardar_config(int user_number);
    Q_INVOKABLE int cambiar_pass(int user_number,QString oldpass, QString newpass, QString confirm);
    Q_INVOKABLE void cambiar_telefono(int user_number,QString newpass);


private:
    Q_INVOKABLE QString nombres[5]={"user1","user2","","",""};
    Q_INVOKABLE QString passes[5]={"qwe","asd","zxc","qwe","asd"};
signals:

public slots:
};

#endif // MEMORIACONFIG_H
