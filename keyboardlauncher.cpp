//Codigos copiados de https://www.youtube.com/watch?v=xpkP5ZDThb0

#include "keyboardlauncher.h"

KeyboardLauncher::KeyboardLauncher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
}

void KeyboardLauncher::launchKeyboard()
{
    m_process->start("sh /home/pi/On-Screen\\ Keyboard.sh");
}
