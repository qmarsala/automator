#Include, %A_ScriptDir%\legacy\MouseMove.ahk

fuzzy_Delay(i := 50, range := 10)
{
    thisDelay := fuzzy_Number(i, range)
    Sleep, thisDelay
    Return
}

fuzzy_Click(i := 50, range := 10)
{
    Click, down
    fuzzy_Delay(i, range)
    Click, up
    fuzzy_Delay(i, range)
}

fuzzy_RightClick(i := 50, range := 10)
{
    Click, down, right
    fuzzy_Delay(i, range)
    Click, up, right
    fuzzy_Delay(i, range)
}

fuzzy_Number(i, range)
{
    Random, rand, -%range%, %range%
    i := i + rand
    Return i
}