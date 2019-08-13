# Welcome to Automator    
## Hotkeys    
Control F1 - Open menu    
Control F2 - Restart automator    
    
The current version of Automator is largely the limited implementation used to come up with and test the original idea.    
Only inline functions work as documented with the exception that the context works a bit differently.    
You will be passed a context object, but it cannot be changed and only has a playbackLoopCount property.    
Setup commands also work but are setup like this ```>f>functionName``` and have the following limitations:    
Only one per script.    
Aliases can only be once char.    
They are also invoked differently as well.    
Instead of placing the alias inbetween two + chars, the letter takes the place of the sleepMs position in the command.    
ex: ```f,0,200,200```    


*Note: the follwoing documents a future state of the automator, and for now serves as a requirements/preview of whats to come document.*
## The click logger    
press control f1 to open the main menu    
then select log clicks.    
this will capture your click actions and write a .recipy in \output\clicklog.recipy    
this file can be modified by adding custom commands.    


## The playback    
The playback works be reading a recipy stored in a file from \automator\recipes folder with the .recipy extension.    
.recipy files consist of a list of commands read from the top down.  
### a .recipy file    
```
++100,1,200,225    
++50,0,225,225
```    
this is a simple .recipy file that will wait 100 ms before right clicking at x = 200px and y = 225px from the top left corner of the current active window.  After that it will wait 50 ms and left click at x = 225 and y = 225    
*Note: the contents of the recipy define actions for one iteration of playback.  When starting a recipy you will be asked how many times to repeat the recipy.*
    
these files can become more complex to add dynamic behavior like this
```
++100,1,200,225    
>ifOptionPresent
++50,0,225,225
```    
lets take a look at commands to see what is possible.

# commands    
There are two types of commands, click commands and continuation predicate commands    
    
## click commands
click commands are regular clicks denoted by the double plus syntax ```++``` in your clicklog.
click commands look like this:    
```++delayMs,isRightClick,clickX,clickY```    

#### Pre-click Processing Pipeline
The double plus syntax allows you to setup a pre click processing pipeline.    
Provide a comma seperated list of functions to call (called from left to right) between the plus signs.        
These functions must be defined in the \dynamics\functions.ahk file.    
```+funcName1,funcName2+delayMs,isRightClick,clickX,clickY```    

Each function will be passed a context object with the following properties:
- clickArgs
    - preClickDelayMs
    - clickX
    - clickY
    - isRightClick
- bag
- playbackLoopCount    
    
**clickArgs** shows you the values that will be used for the next click.  You can update these in your function if needed.    
**bag** is an associative array for you to hang on to state that you need persisted through each click for the duration of the recipy's playback.  
**playbackLoopCount** shows you the current loop count in the recipy's playback.    

#### Function Alias
to setup a function alias, use ':' before and after your alias,
followed by the name of the function that should be invoked.    
```:maf:myAliasedFunction``` (setup dynamic click behavior tied to 'maf')    
```+maf+delayMs,isRightClick,clickX,clickY``` (use the alias)    

### The click
A click command will send a mouse click command, after pre-click processing pipeline.    
The default arguments are specified in line following the double plus and are as follows:    
**delayMs** controls how long in miliseconds to pause before sending the click command.    
**isRightClick** either a 1 or 0.  1 for right click, 0 for left click.    
**clickX** the X coordinate to click
**clickY** the Y coordinate to click    
*Note: (0,0) is the top left of the current active window.*    
    
Any changes to these values in the context object passed to the pre-click pipeline will be used instead.
    
## continuation predicate commands    
continuation predicate commands are user defined functions in the \dynamics\functions.ahk file.    
continuation predicate commands look like this:    
```<functionName``` (run this function, first loop)    
```>functionName ``` (run this function, each loop)    
continuation predicate commands will be passed a context object with the following properties:
- bag
- playbackLoopCount     

the return value of these functions should be a bool.  This will determin if subsequent commands should be processed, or if the current iteration of the recipy should conclude here.  true to continue, false to end the current loop iteration.   

# Examples    
To use an aliased pre-click function, place the alias between the two '+' chars of a regular click action.    
```
:df:demoFunc
+df+0,1,100,100
+df+0,0,110,120
```    
you can add multiple setup commands to a single click action like this

```
:a:demoFuncA
:b:demoFuncB
+a,b+delayMs,isRightClick,clickX,clickY
```    
any inputs to the commands you do not need can be ommited.    
for example, if you did not need the original intended click data, you could invoke the pipeline like this    

```
:a:demoFuncA
:b:demoFuncB
+a,b+
```    
this will require your functions to provide all data points to be used in the click action.    
If you provide values in the command, they will be the values of the context's clickArgs passed to your function calls, and serve as default click data.  This can be useful when you want to dynamically wait before clicking a known location.  Or when you want to wait a known amount of time before clicking a dynamic location.    
example:    
waiting dynamic time for known click

```
:wait:waitForMenu
+wait+0,0,100,100
```    
waiting known time for dynamic click
```
:cot:clickOptionTwo
+cot+100,0,0,0
```    
default values you do not want to override can be ommited, so the above is the same as    
```
:cot:clickOptionTwo
+cot+100
```    
putting commas with empty values will use the last commands values    
```
:cot:clickOptionTwo
++100,0,20,200
+cot+,,,,  <-- this will be passed 100,0,20,200 as the default values
```    

## More on the examples
sample of what the implementations inside functions.ahk file may look like for the above example .recipy's.

```ahk
ifOptionPresent(context)
{
    WinGetPos,,, aWidth, aHeight, A
    ImageSearch, foundX, foundY, 0, 0, aWidth, aHeight, *20 images\option.png
    return ErrorLevel = 0
}

clickOptionTwo(context)
{
    optionOffset := 35
    origClickY := context.clickArgs.clickY
    context.clickArgs.clickY := origClickY + optionOffset
}

waitForMenu(context)
{
    while menuNotVisable()
    {
        Sleep, 500
    }
}

menuNotVisable()
{
    WinGetPos,,, aWidth, aHeight, A
    ImageSearch, foundX, foundY, 0, 0, aWidth, aHeight, *20 images\menu.png
    return ErrorLevel != 0
}
```
