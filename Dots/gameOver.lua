local composer = require("composer")
local scene = composer.newScene()
local sfx = require("sfx")

local ui = require("ui")

local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight

-- Called when the scene's view does not exist:
function scene:create( event )
    local sceneGroup = self.view
    print( "\n Game Over Screen: create event" )
end

function scene:show( event )
    local sceneGroup = self.view
    print( "\n Game Over Screen: show event" )
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        local winnerText = display.newText(sceneGroup, string.format("%s won the game!", event.params.winner), 0, 0, native.systemfont,24)
        winnerText.x = WIDTH/2
        winnerText.y = HEIGHT/2
        local scoreText = display.newText(sceneGroup, string.format("Score: %d", event.params.score), 0, 0, native.systemfont,24)
        scoreText.x = WIDTH/2
        scoreText.y = HEIGHT/2 + 24
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end

function scene:hide(event)
    local phase = event.phase
    print( "\n Game Over Screen: hide event" )

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

-- Called prior to the removal of scene's "view" (displaygroup)
function scene:destroy( event )
    print( "\n Game Over Screen: destroy event" )
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