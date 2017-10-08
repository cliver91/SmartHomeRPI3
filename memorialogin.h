#ifndef MEMORIALOGIN_H
#define MEMORIALOGIN_H

#include <QObject>
#include <QDebug>
#include <QPoint>

class MemoriaLogin : public QObject
{
    Q_OBJECT
public:
    explicit MemoriaLogin(QObject *parent = nullptr);

    Q_INVOKABLE void test();
    Q_INVOKABLE int login_input(int user_number,QString pass);
    Q_INVOKABLE QString get_user(int);
    Q_INVOKABLE int get_user_num();

private:
    Q_INVOKABLE QString nombres[5]={"user1","user2","","",""};
    Q_INVOKABLE QString passes[5]={"qwe","asd","zxc","qwe","asd"};
signals:

public slots:
};

#endif // MEMORIALOGIN_H
