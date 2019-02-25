#Persistent
#SingleInstance force
#Warn, ClassOverwrite

#Include %A_ScriptDir%\lib\logger.ahk
#Include %A_ScriptDir%\lib\record\clickEventHub.ahk
#Include %A_ScriptDir%\lib\file.ahk
#Include %A_ScriptDir%\lib\settings.ahk
#Include %A_ScriptDir%\lib\menu.ahk
#Include %A_ScriptDir%\legacy\playback.ahk

SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Window

buildMenu()
registerClickEventHandlers()
info("configuration complete.")
Return

^F1::showMenu()
Return

^F2::Reload
Return