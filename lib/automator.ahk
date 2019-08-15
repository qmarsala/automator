#Include %A_ScriptDir%\legacy\fuzzy.ahk
#Include %A_ScriptDir%\legacy\mouse.ahk
#Include %A_ScriptDir%\lib\file.ahk
#Include %A_ScriptDir%\lib\logger.ahk
#Include %A_ScriptDir%\lib\pipeline.ahk
#Include %A_ScriptDir%\lib\command.ahk
#Include %A_ScriptDir%\lib\commandFactory.ahk
#Include %A_ScriptDir%\lib\settings.ahk
#Include %A_ScriptDir%\lib\menu.ahk
#Include %A_ScriptDir%\lib\record\clickEventHub.ahk
#Include %A_ScriptDir%\lib\playback\runtime.ahk
#Include %A_ScriptDir%\dynamics\functions.ahk

buildMenu()
registerClickEventHandlers()