-- Helper classes for creating elements
local composer = require("composer")
local ui = require("ui")

-- Initializes the scene so that we can begin putting objects on the page
local scene = composer.newScene()

-- Helper variables for getting the max height and width of the page
local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight

local gridLines = composer.getVariable("dotLines") or 5

local linesGroup
local linesLabel

function scene:create( event )
    local sceneGroup = self.view
    composer.removeScene( "loadgame" )
    composer.removeScene( "mainmenu" )
    composer.removeScene( "dots" )

    print( "\n Settings: create event" )

    -- Creates a label at the top of the screen
    local settingsLabel
    settingsLabel = display.newText(sceneGroup, "Settings", WIDTH/2, 0, native.systemfont, 24)

    linesGroup = display.newGroup()

    local increaseWidth = function( event )
         if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridLines < 11 then
                gridLines = gridLines + 1
                linesLabel.text = string.format("%d lines on the grid", gridLines-1)
            end
        end
    end

    local decreaseWidth = function( event )
        if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridLines > 4 then
                gridLines = gridLines - 1
                linesLabel.text = string.format("%d lines on the grid", gridLines-1)
            end
        end
    end

    local incrementBtn

    incrementBtn = ui.newButton{
		-- defaultX = WIDTH/2,
		-- defaultY = 36,
		-- overX = WIDTH/2,
		-- overY = 36,
		onEvent = increaseWidth,
		id = "IncrementLinesBtn",
		text = "+",
		font = native.systemfont,
		textColor = { 255, 255, 255, 255 },
		size = 24,
		emboss = false
	}
    incrementBtn.x = WIDTH/5; 
    incrementBtn.y = 36;
    linesGroup:insert(incrementBtn)

    local decrementBtn

    decrementBtn = ui.newButton{
		-- defaultX = WIDTH/2,
		-- defaultY = 36,
		-- overX = WIDTH/2,
		-- overY = 36,
		onEvent = decreaseWidth,
		id = "DecrementLinesBtn",
		text = "-",
		font = native.systemfont,
		textColor = { 255, 255, 255, 255 },
		size = 24,
		emboss = false
	}
    decrementBtn.x = WIDTH/5 + 24; 
    decrementBtn.y = 36;
    linesGroup:insert(decrementBtn)

    linesLabel = display.newText(linesGroup, string.format("%d lines on the grid", gridLines-1), WIDTH/5*3, 36, native.systemfont, 18)

    sceneGroup:insert(linesGroup)
end

function scene:show( event )
    local sceneGroup = self.view
    print( "\n Settings: show event" )

    
    
    
end

function scene:hide()
    print ("\n Settings: hide event")
end

function scene:destroy(event)
    print("\n Settings: destroy event")
end

-- "create" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )

-- "show" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "hide" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )

-- "destroy" event is dispatched before view is unloaded, which can be
scene:addEventListener( "destroy", scene )
return scene