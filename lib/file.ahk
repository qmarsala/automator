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
    global clickLogFilePath
    global recipesDir
    newRecipyPath := % recipesDir . "\" . recipyName . ".recipy"
    FileCopy, %clickLogFilePath%, %newRecipyPath%
    return "Success"
}