#Include, %A_ScriptDir%\lib\file.ahk

registerClickEventHandlers()
{
    Hotkey, ~LButton, _onLeftClick
    Hotkey, ~RButton, _onRightClick
    toggleClickEventHandlers()
}

toggleClickEventHandlers()
{
    Hotkey, ~LButton, Toggle
    Hotkey, ~RButton, Toggle
}

_onLeftClick()
{
    _handleClick(false)
}

_onRightClick()
{
    _handleClick(true)
}

_handleClick(rightClick)
{
    diff := A_TimeSinceThisHotkey - A_TimeSincePriorHotkey
    diff := diff = "" ? 0 : (diff * -1)
    MouseGetPos, xOut, yOut
    mouseEvent := {timeDelta: diff, isRightClick: rightClick, x: xOut, y: yOut}
    _writeEvent(mouseEvent)
}

_writeEvent(mouseEvent)
{
    line := Format("++{},{},{},{}", mouseEvent.timeDelta, mouseEvent.isRightClick, mouseEvent.x, mouseEvent.y)
    appendLine(line, global clickLogFilePath)
}