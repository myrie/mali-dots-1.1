-----------------------------------------------------------------------------------------
--
-- gameScene.lua
--
-- This is the scene in which the game is played
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local sfx = require("sfx")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- load in dots

local dots = require( "dots" )

-- get display dimensions

local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight

-- figure out size and location of grid

local SIZE = (math.min(HEIGHT, WIDTH))*0.9
local LOCATION = {x = (WIDTH - SIZE)/2, y = (HEIGHT - SIZE)/2}

-- set the number of lines in the grid
local LINES = dots.LINES
local GAPS = LINES-1
local CELL_SIZE = SIZE/GAPS
local EDGE_SIZE = 6

local btnSound = sfx.click

-- -----------------------------------------------------------------------------------
-- user interface stuff
-- -----------------------------------------------------------------------------------

-- the grid of cells
local cells = {}
-- the horizontal edges
local horizontals = {}
-- the vertical edges
local verticals = {}
-- colours to use for cells
local colors = {
	red = {1.0, 0.0, 0.0},
	yellow = {1.0, 1.0, 0.0}
}
-- colours to use for edges
local OPEN_EDGE_COLOR = {0.5, 0.5, 0.5}
local TAKEN_EDGE_COLOR = {0.0, 0.5, 1.0}
-- colour to use for vertices
local VERTEX_COLOR = {1.0, 1.0, 1.0}
local BACKGROUND_COLOR = {255.0, 255.0, 255.0}

-- forward references for text objects
local scoreText 
local playerText 

-- show the current score/player info
local function updateScores()	
	scoreText.text = "red : " .. dots.players.red.score .. " versus yellow: " .. dots.players.yellow.score
	playerText:setFillColor(unpack(colors[dots.currentPlayer]))
	playerText.text = dots.currentPlayer .. " to play"

	if dots:isOver() then
		print("\n game over")
		local winningUser;
		local winningScore
		if dots.players.red.score > dots.players.yellow.score then
			winningUser = "red"
			winningScore = dots.players.red.score
		else
			winningUser = "yellow"
			winningScore = dots.players.yellow.score
		end

		local options = {
    		effect = "fade",
			params = {
				winner = winningUser,
				score = winningScore
			}
		}

		composer.showOverlay("gameOver", options)
	end
end

-- register an event listener for game updates
local function onUpdate( player, row, column )
	-- print(string.format("\n onUpdate player: %s, row: %d, column: %d", player, row, column))
	cells[row][column]:setFillColor(unpack(colors[player]))
	cells[row][column].alpha = 0.3
end

-- user interaction

-- reset the board/scores for the start of a game
local function newGame(lines)

	for i = 1, lines-1 do
		for j = 1, lines-1 do
			cells[i][j]:setFillColor(unpack(BACKGROUND_COLOR))
			cells[i][j].alpha = 0
		end
	end	
	
	for i = 1, lines do
		for j = 1, lines-1 do
			horizontals[i][j]:setFillColor(unpack(OPEN_EDGE_COLOR))
			horizontals[i][j].owner = nil
		end
	end

	for j = 1, lines do
		for i = 1, lines-1 do
			verticals[j][i]:setFillColor(unpack(OPEN_EDGE_COLOR))
			verticals[j][i].owner = nil
		end
	end
	composer.hideOverlay("fade", 400)
	
	dots:newGame(lines)
	updateScores()
	dots:addListener(onUpdate)
end

-- respond to clicks on horizontal edges
local function onTouchHorizontal(event)
	if event.phase == "ended" then
		local row = event.target.row
		local col = event.target.col
		audio.play(sfx.click)
		if not horizontals[row][col].owner then
			horizontals[row][col].owner = dots.currentPlayer
			horizontals[row][col]:setFillColor(unpack(TAKEN_EDGE_COLOR))
			dots:doHorizontal(row, col)
			updateScores()
			
		end
		return true
	end
end

-- and vertical edges
local function onTouchVertical(event)
	if event.phase == "ended" then
		local row = event.target.row
		local col = event.target.col
		audio.play(sfx.click)
		if not verticals[col][row].owner then
			verticals[col][row].owner = dots.currentPlayer
			verticals[col][row]:setFillColor(unpack(TAKEN_EDGE_COLOR))
			dots:doVertical(row, col)
			updateScores()
		end
		return true
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    
    -- Code here runs when the scene is first created but has not yet appeared on screen

	local returnHome = function(event)
        if event.phase == "release" then
            audio.play(btnSound)
            composer.gotoScene( "mainmenu", "fade", 300 )
        end
    end

    local returnBtn = ui.newButton{
        onEvent = returnHome,
        id = "ReturnHomeBtn",
        text = "Menu",
        font = native.systemfont,
        textColor = { 255, 255, 255, 255 },
        size = 18,
        emboss = false
    }
    returnBtn.x = WIDTH/3
    returnBtn.y = HEIGHT

    sceneGroup:insert(returnBtn)

	local newGameBtn = function(event)
        if event.phase == "release" then
            audio.play(btnSound)
            newGame(LINES)
        end
    end

    local newGameButton = ui.newButton{
        onEvent = newGameBtn,
        id = "NewGameBtn",
        text = "New Game",
        font = native.systemfont,
        textColor = { 255, 255, 255, 255 },
        size = 18,
        emboss = false
    }
    newGameButton.x = WIDTH/3*2
    newGameButton.y = HEIGHT

    sceneGroup:insert(newGameButton)

	-- and the score

	scoreText = display.newText(sceneGroup, "", 0, 0, native.systemfont, 24)
	scoreText.x = WIDTH/2
	scoreText.y = scoreText.height/2 + 10	
	
	playerText = display.newText(sceneGroup, "", 0, 0, native.systemfont, 24)
	playerText.x = WIDTH/2
	playerText.y = scoreText.y + 24
	
end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		LINES = composer.getVariable('gridSize')
		initializeGame(sceneGroup, LINES)
		
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end

function initializeGame(sceneGroup, lines)
	print("\n Called Initialize Game")
	GAPS = lines-1
	CELL_SIZE = SIZE/GAPS

	cells = {}
	for i = 1, lines-1 do
		cells[i] = {}
		local y = LOCATION.y + (i-1) * CELL_SIZE
		for j = 1, lines-1 do
			local x = LOCATION.x + (j-1) * CELL_SIZE
			cells[i][j] = display.newRect(sceneGroup, x, y, CELL_SIZE, CELL_SIZE)
			cells[i][j].anchorX = 0
			cells[i][j].anchorY = 0
		end
	end	
	
	horizontals = {}
	for i = 1, lines do
		horizontals[i] = {}
		local y = LOCATION.y + (i-1) * CELL_SIZE
		for j = 1, lines-1 do
			local x = LOCATION.x + (j-1) * CELL_SIZE
			horizontals[i][j] = display.newRect(sceneGroup, x, y, CELL_SIZE, EDGE_SIZE)
			horizontals[i][j].anchorX = 0
			horizontals[i][j]:addEventListener( "touch", onTouchHorizontal )
			horizontals[i][j].row = i
			horizontals[i][j].col = j
		end
	end

	verticals = {}
	for j = 1, lines do
		verticals[j] = {}
		local x = LOCATION.x + (j-1) * CELL_SIZE
		for i = 1, lines-1 do
			local y = LOCATION.y + (i-1) * CELL_SIZE
			verticals[j][i] = display.newRect(sceneGroup, x, y, EDGE_SIZE, CELL_SIZE)
			verticals[j][i].anchorY = 0
			verticals[j][i]:addEventListener( "touch", onTouchVertical )
			verticals[j][i].row = i
			verticals[j][i].col = j
		end
	end

	-- and white dots

	for i = 1, lines do
		local y = LOCATION.y + (i-1) * CELL_SIZE
		for j = 1, lines do
			local x = LOCATION.x + (j-1) * CELL_SIZE
			local dot = display.newCircle(sceneGroup, x, y, EDGE_SIZE)
			dot:setFillColor(unpack(VERTEX_COLOR))
		end
	end

	newGame(lines)
end

-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view

    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene