
local composer = require("composer")
local scene = composer.newScene()

local ui = require("ui")

local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight

function scene:create( event )
    local sceneGroup = self.view
    composer.removeScene( "loadgame" )
    composer.removeScene( "mainmenu" )
    composer.removeScene( "dots" )
    print( "\nmainmenu: create event" )
end

function scene:show( event )

 local sceneGroup = self.view
    print( "\nmainmenu: show event" )

    local playBtn
    
    local gridWidth = 5
    local gridHeight = 5
    local increaseWidth = function( event )
         if event.phase == "release" then
            -- audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridthWidth < 11
            gridWidth = gridWidth +1
        end
    end
    
     local decreaseWidth = function( event )
         if event.phase == "release" then
            // audio.play(btnSound)
            -- composer.gotoScene( "gameScene", "fade", 300 )
            if gridthWidth > 2
            gridWidth = gridWidth - 1
            end
    end


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