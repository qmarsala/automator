#Include, %A_ScriptDir%\lib\fileAppender.ahk

debug(message)
{
    _writeLog("debug", message)
}

info(message)
{
    _writeLog("info", message)
}

error(message)
{
    _writeLog("error", message)
}

_writeLog(level, message)
{
    line := Format("[{}] {}", level, message)
    appendLine(line, global logFilePath)
}