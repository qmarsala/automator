buildMenu()
{
    recipesDir := Settings.RecipesDir
    Menu, MainMenu, Add, Log Clicks, _toggleClickLogHandler
    Menu, MainMenu, Add, Save Last Click Log, _saveClickLogHandler
    Menu, MainMenu, Add
        loop, files, %recipesDir%\*.recipy
        {
            Menu, PlaybackMenu, Add, %A_LoopFileName%, _playbackHandler
        }
    Menu, MainMenu, Add, Replay Clicks, :PlaybackMenu
}

showMenu()
{
    Menu, MainMenu, Show
}

_toggleClickLogHandler()
{
    Menu, MainMenu, ToggleCheck, Log Clicks
    toggleClickEventHandlers()
}

_saveClickLogHandler()
{
    InputBox, recipyName, Save As, Recipy Name:
    message := saveNewRecipy(recipyName)
    MsgBox,,, %message%
}

_playbackHandler()
{
    filePath := Settings.RecipesDir . "\" . A_ThisMenuItem
    InputBox, loopCount, Setup Playback, How many loops?
    playback(filePath, loopCount)
}