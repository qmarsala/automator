class Pipeline {
    _head := {}

    __New(pStep = "") {
        this._head := pStep
    }

    Execute(executionContext) {
        this._head.Execute(executionContext)
    }

    AddStep(pStep) {
        if (this._head = "") {
            this._head := pStep
        } else {
            next := this._head
            while (next._next != "") {
                next := next._next
            }
            next._next := pStep
        }
    }
}

class PipelineStep {
    _function := {}
    _next := {}

    __New(functionName, next = "") {
        this._function := Func(functionName)
        this._next := next
    }

    Execute(executionContext) {
        this._function.Call(executionContext)
        if (this._next != "") {
            this._next.Execute(executionContext)
        }
    }
}