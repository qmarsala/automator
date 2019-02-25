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

keepFileSmallerThanMb(filePath, maxSizeMb := 1)
{
    FileGetSize, logFileSize, %filePath%, M
    if (logFileSize >= maxSizeMb)
    {
        FileDelete, %filePath%
    }
}