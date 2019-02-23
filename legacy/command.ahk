#Include, %A_ScriptDir%\legacy\mouse.ahk

class FunctionCommand 
{
    functionName := ""
    function := ""
    context := {}

    __New(functionName, context)
    {
        this.functionName := functionName
        this.function := Func(functionName)
        this.context := context
    }

    execute()
    {
        return this.function.Call(this.context)
    }

    __Delete()
    {
        this.context := ""
        this.function := ""
    }
}

class ClickActionCommand
{
    sleepMs := ""
    isRightClick := ""
    clickX := ""
    clickY := ""

    __New(sleepMs, isRightClick, clickX, clickY)
    {
        this.sleepMs := sleepMs
        this.isRightClick := isRightClick
        this.clickX := clickX
        this.clickY := clickY
    }

    execute()
    {
        if (this.sleepMs > 0)
        {
            fuzzy_Delay(this.sleepMs)
        }
        if (this.sleepMs = this.context.contextualDelayId)
        {
            this.context.contextualDelayFn.execute()
        }

        if (this.isRightClick)
        {
            rightClick(this.clickX, this.clickY)
            return true
        }
        click(this.clickX, this.clickY)
        return true
    }
}

class DynamicClickActionCommand extends ClickActionCommand
{
    context := ""

    __New(sleepMs, isRightClick, clickX, clickY, context)
    {
        base.__New(sleepMs, isRightClick, clickX, clickY)
        this.context := context
    }

    __Delete()
    {
        this.context := ""
    }
}