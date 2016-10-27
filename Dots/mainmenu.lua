local composer = require("composer")
local scene = composer.newScene()

local myTimer
local loadingImage
-- Called when the scene's view does not exist:
function scene:create( event )
    local sceneGroup = self.view
    print( "\nloadmainmenu: create event" )
end

-- Called immediately after scene has moved onscreen:
function scene:show( event )
local sceneGroup = self.view
print( "loadmainmenu: show event" )
loadingImage = display.newImageRect( "loading.png", 480, 320)
loadingImage.x = 240; loadingImage.y = 160
sceneGroup:insert( loadingImage )
myTimer = timer.performWithDelay( 1000, goToMenu, 1 )

    local goToMenu = function()
      composer.gotoScene( "mainmenu", "zoomOutInFadeRotate", 500)
    end

end

function scene:hide()
if myTimer then timer.cancel( myTimer ); end
print( "loadmainmenu: hide event" )
end
-- Called prior to the removal of scene's "view" (displaygroup)
function scene:destroy( event )
    print( "destroying loadmainmenu's view" )
end

-- "create" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )
-- "show" event is dispatched whenever scene transition has
finished
scene:addEventListener( "show", scene )
-- "hide" event is dispatched before next scene's transition
begins
scene:addEventListener( "hide", scene )
-- "destroy" event is dispatched before view is unloaded, which
can be
scene:addEventListener( "destroy", scene )
return scene