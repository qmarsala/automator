# Welcome to Automator    
*Note: the follwoing documents a future state of the automator, and for now serves as a requirements/preview of whats to come document.*
## The click logger    
press f4 to open the main menu    
then select log clicks.    
this will capture your click actions and write a .recipy in \output\clicklog.recipy    
this file can be modified by adding custom commands.    


## The playback    
The playback works be reding a recipy stored in a file from \automator\recipes folder with the .recipy extension.    
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

## commands    
There are two main types of commands, setup commands and automator commands    
### **setup commands**    
setup commands are user defined functions in the \dynamicbehaviors\onClick.ahk file.    
these lines will tie the invocation of that function to an alias that can be used in automator commands.    

to setup a function to run on click events, use ':' before and after your alias,
followed by the name of the function that should be invoked.    
```:myAlias:functionName``` (setup dynamic click behavior tied to 'myAlias')    
the function will be passed a context object with the following properties:    
- preClickDelayMs
- clickX
- clickY
- isRightClick
- playbackLoopCount
    
the function should return an object with the same properties with new calculated values for the click.    
any property not returned will use default values. (more on those later.)
*Note: you do not need to return a playbackLoopCount value, you cannot update this property*

### **action commands**    
action commands are regular clicks often from your clicklog, and user defined functions in the \dynamicbehaviors\actions.ahk file.    
these actions can be placed anywhere following the setup actions, and will run in the order they are in from top down.    
regular clicks look like this:    
```++delayMs,isRightClick,clickX,clickY```    
in place actions look like this:    
```<functionName``` (run this function in place, first loop)    
```>functionName ``` (run this function in place, each loop)    
in place actions are function that will be passed a context object with the following properties by default
- playbackLoopCount
    
the return value of these functions should be a bool.  this will determin if subsequent commands should be processed, or if the recipy should conclude here.  true to continue, false to end the current loop iteration.    
*Note: this object is dynamic and you can add properties to it to be accessed by other action commands, and/or in subsequant playback loops.*    

## Using setup commands in action commands    
to use a setup command, place the alias of the setup between the two '+' chars of a regular click action.    
```
:df:demoFunc
+df+delayMs,isRightClick,clickX,clickY
+df+delayMs,isRightClick,clickX,clickY
```    
you can add multiple setup commands to a single click action like this

```
:a:demoFuncA
:b:demoFuncB
+a,b+delayMs,isRightClick,clickX,clickY
```    
when binding setup commands to click actions, any inputs to the commands you do not need can be ommited.    
for example, if you did not need the original intended click data, you could invoke both set up commands like this    

```
:a:demoFuncA
:b:demoFuncB
+a,b+
```    
this will require your functions to provide all data points to be used in the click action.    
if you provide values, they will be the values of the context passed to your function calls, and serve as default click data.  This can be useful when you want to dynamically wait before clicking a known location.  Or when you want to wait a known amount of time before clicking a dynamic location.    
example:    
waiting dynamic time for known click

```
-wait-waitForMenu
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
sample onClick.ahk file to show what the implementations may look like for the above example .recipy's.

```ahk
ifOptionPresent(context)
{
    WinGetPos,,, aWidth, aHeight, A
    ImageSearch, foundX, foundY, 0, 0, aWidth, aHeight, *20 images\option.png
    return ErrorLevel = 0
}

clickOptionTwo(context)
{
    contextUpdates := {}
    contextUpdates.clickY := context.clickY + 35
    return contextUpdates
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
