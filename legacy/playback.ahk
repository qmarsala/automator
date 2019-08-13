#Include, %A_ScriptDir%\dynamics\functions.ahk
#Include, %A_ScriptDir%\legacy\commandBuilder.ahk

playback(filePath, maxLoops)
{
    context := {playbackLoopCount: 0, contextualDelayId: "", contextualDelayFn: ""}
    commands := readCommands(filePath, context)
    Loop, %maxLoops%
    {
        context.playbackLoopCount := A_Index
        executeCommands(commands)
    }
}

readCommands(filePath, context)
{
    commands := []
    Loop, read, %filePath%
    {
        command := buildCommand(A_LoopReadLine, context)
        if (command = "contextualFn")
        {
            continue
        }
        commands.push(command)
    }
    return commands
}

executeCommands(commands)
{
    for index, command in commands
    {
        shouldContinue := command.execute()
        if (!shouldContinue)
        {
            return
        }
    }
}