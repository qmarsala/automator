class Command {
    _executionContext := {}

    __New() {
        this._executionContext := {}
    }

    __Delete() {
        this._executionContext := {}
    }

    Execute(playbackIterator, playbackBag) {
        this._AddRuntimeContextToContext(playbackIterator, playbackBag)
        this._OnBeforeExecute()
        this._InnerExecute()
        this._OnAfterExecute()
    }

    _AddRuntimeContextToContext(playbackIterator, playbackBag) {
        this._executionContext.Iterator := playbackIterator
        this._executionContext.Bag := playbackBag
    }

    _OnBeforeExecute() { 
        ; noop default
    }

    _InnerExecute() { 
        ; noop default
    }

    _OnAfterExecute() { 
        ; noop default
    }
}

class ClickCommand extends Command {
    _delayMs := 0
    _clickX := 0
    _clickY := 0
    _isRightCick := false
    _pipeline := {}

    __New(delayMs, clickX, clickY, isRightClick, pipeline) {
        this._delayMs := delayMs
        this._clickX := clickX
        this._clickY := clickY
        this._isRightCick := isRightClick
        this._pipeline := pipeline
        this._executionContext.ClickArgs := { DelayMs: this._delayMs, X: this._clickX, Y: this._clickY, IsRightClick: this._isRightCick }
    }

    __Delete() {
        this._pipeline := {}
    }

    _OnBeforeExecute() {
        this._pipeline.Execute(this._executionContext)
        debug("ClickCommand finished OnBeforeExecute")
    }

    _InnerExecute() {
        _clickArgs := this._executionContext.ClickArgs
        if (_clickArgs.DelayMs > 0)
        {
            fuzzy_Delay(_clickArgs.DelayMs)
        }

        if (_clickArgs.IsRightClick)
        {
            rightClick(_clickArgs.X, _clickArgs.Y)
        } else {
            click(_clickArgs.X, _clickArgs.Y)
        }
        debug("ClickCommand finished InnerExecute")
    }

    _OnAfterExecute() {
        debug("ClickCommand finished OnAfterExecute")
    }
}

class PredicateCommand extends Command {
    ShouldContinue := true
    _predicateFn := {}
        
    __New(predicateFnName) {
        this._predicateFn := Func(predicateFnName)
    }

    __Delete() {
        this._predicateFn := {}
    }

    _OnBeforeExecute() {
        debug("PredicateCommand finished OnBeforeExecute")
    }

    _InnerExecute() {
        this.ShouldContinue := this._predicateFn.Call(this._executionContext)
        debug("PredicateCommand finished InnerExecute")
    }

    _OnAfterExecute() {
        debug("PredicateCommand finished OnAfterExecute")
    }
}