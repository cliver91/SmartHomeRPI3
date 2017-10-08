//Codigos copiados de https://talk.maemo.org/showthread.php?t=87580

#include "scriptlauncher.h"

ScriptLauncher::ScriptLauncher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
}

void ScriptLauncher::launchScript()
{
    m_process->start("sh /home/pi/On-Screen Keyboard.sh");
}
