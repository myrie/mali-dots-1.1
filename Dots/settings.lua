-- Helper classes for creating elements
local composer = require("composer")
local ui = require("ui")

-- Initializes the scene so that we can begin putting objects on the page
local scene = composer.newScene()

-- Helper variables for getting the max height and width of the page
local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight

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
end

function scene:show( event )
    local sceneGroup = self.view
    print( "\n Settings: show event" )

    local playBtn
    
    local gridWidth = 5
    local gridHeight = 5
    local increaseWidth = function( event )
         if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridthWidth < 11 then
                gridWidth = gridWidth +1
            end
        end
    end
    
    local decreaseWidth = function( event )
        if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridthWidth > 2 then
                gridWidth = gridWidth - 1
            end
        end
    end
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