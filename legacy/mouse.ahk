#Include, %A_ScriptDir%\legacy\fuzzy.ahk

click(x, y)
{
    moveMouse(x, y)
    fuzzy_Delay()
    fuzzy_Click()
}

rightClick(x, y)
{
    moveMouse(x, y)
    fuzzy_Delay()
    fuzzy_RightClick()
}

moveMouse(x, y)
{
    fuzzy_Move(x, y, 1, 5)
}

fuzzy_Move(x, y, range := 2, speed := 10)
{
    BlockInput, On
    WinActivate, ahk_exe RuneLite.exe
    thisX := fuzzy_Number(x, range)
    thisY := fuzzy_Number(y, range)
    MouseGetPos, origX, origY
    fuzzX := fuzzy_Number(thisX, Floor(Abs(origX - thisX) * 0.05))
    fuzzY := fuzzy_Number(thisY, Floor(Abs(origY - thisY) * 0.05))
    MouseMove_Ellipse("", "", fuzzX, fuzzY, speed)
    fuzzy_Delay()
    MouseMove_Ellipse("", "", thisX, thisY, 1)
    BlockInput, Off
}