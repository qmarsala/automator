;todo: make these includes smarter - plug and play with other hosting scripts

#Include %A_ScriptDir%\lib\logger.ahk
#Include %A_ScriptDir%\lib\record\clickEventHub.ahk
#Include %A_ScriptDir%\lib\file.ahk
#Include %A_ScriptDir%\lib\settings.ahk
#Include %A_ScriptDir%\lib\menu.ahk
#Include %A_ScriptDir%\legacy\playback.ahk

buildMenu()
registerClickEventHandlers()