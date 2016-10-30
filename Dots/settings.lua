-- Helper classes for creating elements
local composer = require("composer")
local ui = require("ui")

-- Initializes the scene so that we can begin putting objects on the page
local scene = composer.newScene()
local btnSound = audio.loadSound( "audio/btnSound.wav" )
-- Helper variables for getting the max height and width of the page
local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight
local gridLabel

function getGridLineText(gridSize)
    return string.format("Grid Size: %d", gridSize-1);
end

function scene:create( event )
    local sceneGroup = self.view
    -- composer.removeScene( "mainmenu" )

    print( "\n Settings: create event" )

    -- Creates a label at the top of the screen
    local settingsLabel
    settingsLabel = display.newText(sceneGroup, "Settings", 0, 0, native.systemfont, 24)
    settingsLabel.x = WIDTH/2
    settingsLabel.y = 0

    local increaseSize = function( event )
        if event.phase == "release" then
            -- audio.play(btnSound)
            local gridSize = composer.getVariable("gridSize")
            if gridSize < 11 then
                gridSize = gridSize + 1
                composer.setVariable("gridSize", gridSize)
                gridLabel.text = getGridLineText(gridSize)
            end
        end
    end

    local decreaseSize = function( event )
        if event.phase == "release" then
            -- audio.play(btnSound)
            local gridSize = composer.getVariable("gridSize")
            if gridSize > 4 then
                gridSize = gridSize - 1
                composer.setVariable("gridSize", gridSize)
                gridLabel.text = getGridLineText(gridSize)
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
    IncreaseButton.x = WIDTH/5 + 24
    IncreaseButton.y = 100
    sceneGroup:insert(IncreaseButton)

    DecreaseButton = ui.newButton{
        onEvent = decreaseSize,
        id = "DecreaseSizeBtn",
        text = "-",
        font = native.systemfont,
        textColor = { 255, 255, 255, 255 },
        size = 18,
        emboss = false
    }
    DecreaseButton.x = WIDTH/5
    DecreaseButton.y = 100
    sceneGroup:insert(DecreaseButton)

    gridLabel = display.newText(sceneGroup, getGridLineText(composer.getVariable("gridSize")), WIDTH/5*3, 100, native.systemFont, 16)

    local returnHome = function(event)
        if event.phase == "release" then
            audio.play(btnSound)
            composer.gotoScene( "mainmenu", "fade", 300 )
        end
    end

    returnBtn = ui.newButton{
        onEvent = returnHome,
        id = "ReturnHomeBtn",
        text = "Menu",
        font = native.systemfont,
        textColor = { 255, 255, 255, 255 },
        size = 18,
        emboss = false
    }
    returnBtn.x = WIDTH/2
    returnBtn.y = HEIGHT

    sceneGroup:insert(returnBtn)
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