#Include, %A_ScriptDir%\legacy\command.ahk

;bleh
global functionLineIndicatorChar := ">"
global clickActionDelimeter := ","

buildCommand(line, context)
{
    if (charIsFunctionIndicator(line, 1))
    {
        return buildFunctionCommand(line, context)
    }
    return buildClickActionCommand(line, context)
}

charIsFunctionIndicator(line, index)
{
    functionLineIndicator := SubStr(line, index , 1)
    return functionLineIndicator == global functionLineIndicatorChar
}

buildFunctionCommand(line, context)
{
    if (charIsFunctionIndicator(line, 3))
    {
        context.contextualDelayId := StrSplit(line, global functionLineIndicatorChar)[2]
        functionName := StrSplit(line, global functionLineIndicatorChar)[3]
        command := new FunctionCommand(functionName, context)
        context.contextualDelayFn := command
        return "contextualFn"
    }

    functionName := StrSplit(line, global functionLineIndicatorChar)[2]
    command := new FunctionCommand(functionName, context)
    return command
}

buildClickActionCommand(line, context)
{
    fields := StrSplit(line, global clickActionDelimeter)
    command := new ClickActionCommand(fields[1], fields[2], fields[3], fields[4], context)
    return command
}