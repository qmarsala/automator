appendLine(line, filePath) 
{
    FileAppend % line . "`n", %filePath%
}

saveNewRecipy(recipyName) 
{
    if (recipyName = "") 
    {
        return "Invalid Recipy Name"
    }
    clickLogFilePath := Settings.ClickLogFilePath
    newRecipyPath := Settings.RecipesDir . "\" . recipyName . ".recipy"
    FileCopy, %clickLogFilePath%, %newRecipyPath%
    return "Success"
}

parseRecipy(recipyName) 
{
    recipyPath := Settings.RecipesDir . "\" . recipyName
    commands := []
    debug(recipyPath)
    Loop, Read, %recipyPath%
    {
        debug(A_LoopReadLine)
        commands[A_Index] := createCommand(A_LoopReadLine)
    }
    return commands
}

keepFileSmallerThanMb(filePath, maxSizeMb := 1)
{
    FileGetSize, logFileSize, %filePath%, M
    if (logFileSize >= maxSizeMb)
    {
        FileDelete, %filePath%
    }
}