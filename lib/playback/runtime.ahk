class PlaybackRuntime {
    _bag := {}
    _iterator := 0
    _commands := []

    __New(commands) {
        this._commands := commands
    }

    __Delete() {
        this._bag := {}
        this._commands := []
    }

    Play(times = 1) {
        Loop, %times%
        {
            this._iterator := A_Index
            this._ExecuteCommands()
        }
    }

    _ExecuteCommands()
    {
        for index, c in this._commands
        {
            c.Execute(this._iterator, this._bag)
            if (c.HasKey("ShouldContinue") && !c.ShouldContinue)
            {
                return
            }
        }
    }
}