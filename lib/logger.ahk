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
    FormatTime, fTime,, MM/dd_HH:mm:ss:
    fTime := % fTime . A_MSec
    line := Format("[{}] {} - {}", level, fTime, message)
    appendLine(line, global logFilePath)
}