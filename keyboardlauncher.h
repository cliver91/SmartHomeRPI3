//Codigos copiados de https://www.youtube.com/watch?v=xpkP5ZDThb0

#ifndef KEYBOARDLAUNCHER_H
#define KEYBOARDLAUNCHER_H

#endif // KEYBOARDLAUNCHER_H

#include <QObject>
#include <QProcess>

class KeyboardLauncher : public QObject
{

    Q_OBJECT

public:
    explicit KeyboardLauncher(QObject *parent = 0);
    Q_INVOKABLE void launchKeyboard();

private:
    QProcess *m_process;
};

