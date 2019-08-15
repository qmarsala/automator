clickTopLeft(executionContext) {
    executionContext.ClickArgs.X := 100
    executionContext.ClickArgs.Y := 100
    executionContext.ClickArgs.IsRightClick := 1
}

helloWorld(executionContext) {
    MsgBox, "Hello World!"
}

ifLoopThree(executionContext) {
    if (executionContext.Iterator != 3) {
        return false
    } 
    return true
}