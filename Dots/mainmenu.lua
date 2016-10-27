local composer = require("composer")
local scene = composer.newScene()

-- Called when the scene's view does not exist:
function scene:create( event )
    local sceneGroup = self.view
    print( "\nmainmenu: create event" )
end

-- Called immediately after scene has moved onscreen:
function scene:show( event )
    local sceneGroup = self.view
    print( "\nmainmenu: show event" )
    
end

function scene:hide()
    print( "\nmainmenu: hide event" )
end

-- Called prior to the removal of scene's "view" (displaygroup)
function scene:destroy( event )
    print( "destroying \nmainmenu's view" )
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