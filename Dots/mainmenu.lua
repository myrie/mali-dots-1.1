local composer = require("composer")
local scene = composer.newScene()

local ui = require("ui")
local playBtn


--local btnAnim
--local btnSound = audio.loadSound( "btnSound.wav" )
-- Called when the scene's view does not exist:
function scene:create( event )
    local sceneGroup = self.view
   
    composer.removeScene( "loadgame" )
    composer.removeScene( "settings" )
     composer.removeScene( "dots" )
     print( "\nmainmenu: create event" )
end

-- Called immediately after scene has moved onscreen:
function scene:show( event )
    local sceneGroup = self.view
    print( "\nmainmenu: show event" )
    --local backgroundImage = display.newImageRect("mainMenuBG.png", 480, 320 )
    --backgroundImage.x = 240; backgroundImage.y = 160
    --sceneGroup:insert( backgroundImage )


    local onPlayTouch = function( event )
   
         if event.phase == "release" then
             audio.play( btnSound )
             composer.gotoScene( "loadgame", "fade", 300 )
        end

    end

    playBtn = ui.newButton{
    defaultSrc = "playbtn.png",
    defaultX = 100,
    defaultY = 100,
    overSrc = "playbtn-over.png",
    overX = 100,
    overY = 100,
    onEvent = onPlayTouch,
    id = "PlayButton",
    text = "",
    font = "Helvetica",
    textColor = { 255, 255, 255, 255 },
    size = 16,
    emboss = false
     }

    playBtn.x = 240; playBtn.y = 440
    sceneGroup:insert( playBtn )

    btnAnim = transition.to( playBtn, { time=1000, y=260, transition=easing.inOutExpo } )

    local optBtn

    local onOptionsTouch = function( event )
     if event.phase == "release" then

        audio.play( btnSound )
        composer.gotoScene( "options", "crossFade", 300)

     end
    end

    optBtn = ui.newButton{
        defaultSrc = "optbtn.png",
        defaultX = 60,
        defaultY = 60,
        overSrc = "optbtn-over.png",
        overX = 60,
        overY = 60,
        onEvent = onOptionsTouch,
        id = "OptionsButton",
        text = "",
        font = "Helvetica",
        textColor = { 255, 255, 255, 255 },
        size = 16
        emboss = false
        }

    optBtn.x = 430; optBtn.y = 440
    sceneGroup:insert( optBtn )

    btnAnim = transition.to( optBtn, { time=1000, y=280, transition=easing.inOutExpo } )

end

function scene:hide()
    if btnAnim then transition.cancel( btnAnim ); end
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