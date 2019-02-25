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
    logFilePath := Settings.LogFilePath
    keepFileSmallerThanMb(logFilePath, 1)
    line := _formatLogWithTime(level, message)
    appendLine(line, logFilePath)
}

_formatLogWithTime(level, message)
{
    timeStamp := _getTimeStamp()
    return Format("[{}] {} - {}", level, timeStamp, message)
}

_getTimeStamp()
{
    FormatTime, fTime,, MM/dd_HH:mm:ss:
    return % fTime . A_MSec
}