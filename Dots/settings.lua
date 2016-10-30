-- Helper classes for creating elements
local composer = require("composer")
local ui = require("ui")

-- Initializes the scene so that we can begin putting objects on the page
local scene = composer.newScene()

-- Helper variables for getting the max height and width of the page
local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight
local gridLabel
local gridSize

function scene:create( event )
    local sceneGroup = self.view
    composer.removeScene( "loadgame" )
    composer.removeScene( "mainmenu" )
    composer.removeScene( "dots" )

    print( "\n Settings: create event" )

    -- Creates a label at the top of the screen
    local settingsLabel
    settingsLabel = display.newText(sceneGroup, "Settings", 0, 0, native.systemfont, 24)
    settingsLabel.x = WIDTH/2
    settingsLabel.y = 0

    gridSize = 5

    local increaseSize = function( event )
        if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridSize < 11 then
                gridSize = gridSize + 1
                gridLabel.text = string.format("%d Grid Lines", gridSize-1)
            end
        end
    end

    local decreaseSize = function( event )
        if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridSize > 4 then
                gridSize = gridSize - 1
                gridLabel.text = string.format("%d Grid Lines", gridSize-1)
            end
        end
    end

    local IncreaseButton
    local DecreaseButton

    IncreaseButton = ui.newButton{
        onEvent = increaseSize,
        id = "IncreaseSizeBtn",
        text = "+",
        font = native.systemfont,
        textColor = { 255, 255, 255, 255 },
        size = 18,
        emboss = false
    }
    IncreaseButton.x = WIDTH/5
    IncreaseButton.y = 100

    DecreaseButton = ui.newButton{
        onEvent = decreaseSize,
        id = "DecreaseSizeBtn",
        text = "-",
        font = native.systemfont,
        textColor = { 255, 255, 255, 255 },
        size = 18,
        emboss = false
    }
    DecreaseButton.x = WIDTH/5 + 24
    DecreaseButton.y = 100

    gridLabel = display.newText(sceneGroup, string.format("%d Grid Lines", gridSize-1), WIDTH/5*3, 100, native.systemFont, 16)
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