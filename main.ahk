#Persistent
#SingleInstance force
#Warn, ClassOverwrite
#Include %A_ScriptDir%\lib\logger.ahk
#Include %A_ScriptDir%\lib\record\clickEventHub.ahk

SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Window

;config and startup
global recipesDir := % A_ScriptDir . "\recipes"
global logFilePath := % A_ScriptDir . "\log.txt"
global clickLogFilePath := % recipesDir . "\clicklog.dcsv"

debug("setting up menu")

Menu, MainMenu, Add, Log Clicks, toggleClickLogHandler
Menu, MainMenu, Add
    loop, files, %recipesDir%\*.dcsv
    {
        Menu, PlaybackMenu, Add, %A_LoopFileName%, playbackHandler
    }
Menu, MainMenu, Add, Replay Clicks, :PlaybackMenu

debug("registering click event handlers")

registerClickEventHandlers()

debug("ready")
Return

;Hotkeys
F1::
    info("F1 pressed. - Showing main menu")
    Menu, MainMenu, Show
Return

F2::Reload

;Menu handlers
toggleClickLogHandler:
    Menu, MainMenu, ToggleCheck, Log Clicks
    toggleClickEventHandlers()
Return

playbackHandler:
    filePath := % recipesDir . "\" . A_ThisMenuItem
    MsgBox, , Not supported yet, %filePath%
    ; InputBox, loopCount, Setup Playback, How many loops?
    ; playback(filePath, loopCount)
Return
