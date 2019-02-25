#Persistent
#SingleInstance force
#Warn, ClassOverwrite

#Include, %A_ScriptDir%\lib\automator.ahk

SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Window

info("configuration complete.")
Return

^F1::showMenu()
Return

^F2::Reload
Return