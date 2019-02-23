#Persistent
#SingleInstance force
#Warn, ClassOverwrite
#Include %A_ScriptDir%\lib\logger.ahk
#Include %A_ScriptDir%\lib\record\clickEventHub.ahk
#Include %A_ScriptDir%\legacy\playback.ahk

SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Window

;todo: improve config and startup
global recipesDir := % A_ScriptDir . "\recipes"
global logFilePath := % A_ScriptDir . "\log.txt"
global clickLogFilePath := % recipesDir . "\clicklog.recipy"

debug("setting up menu")

Menu, MainMenu, Add, Log Clicks, toggleClickLogHandler
Menu, MainMenu, Add
    loop, files, %recipesDir%\*.recipy
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
    InputBox, loopCount, Setup Playback, How many loops?
    playback(filePath, loopCount)
Return
