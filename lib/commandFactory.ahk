createCommand(recipeLine) {
    ;todo: validate recipeLine
    if (InStr(recipeLine, "<")) {
        return createOneTimePredicateCommand(recipeLine)
    }   
    if (InStr(recipeLine, ">")) {
        return createPredicateCommand(recipeLine)
    }
    return createClickCommand(recipeLine)
}

createOneTimePredicateCommand(recipeLine) {
    funcName := SubStr(recipeLine, 2)
    return new OneTimePredicateCommand(funcName)
}

createPredicateCommand(recipeLine) {
    funcName := SubStr(recipeLine, 2)
    return new PredicateCommand(funcName)
}

createClickCommand(recipeLine) {
    matchIndex := RegExMatch(recipeLine, "O)\+(.*)\+(.*)", matches)
    pipe := {}
    if (matches[1] != "") {
        pipe := _createPreClickPipeline(matches[1])
    }

    return _createClickCommand(matches[2], pipe)
}

_createPreClickPipeline(funcNames) {
    pipe := new Pipeline()
    Loop, parse, funcNames, `, 
    {
        funcName := A_LoopField
        step := new PipelineStep(funcName)
        pipe.AddStep(step)
    }
    return pipe
}

_createClickCommand(clickArgsString, pipe) {
    clickArgs := []
    Loop, parse, clickArgsString, `, 
    {
        clickArg := A_LoopField
        clickArgs[A_Index] := clickArg
    }
    return new ClickCommand(clickArgs[1], clickArgs[2], clickArgs[3], clickArgs[4], pipe)
}