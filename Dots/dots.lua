-----------------------------------------------------------------------------------------
--
-- dots.lua
--
-- This is the code that manages the game
--
-----------------------------------------------------------------------------------------

local dots = {}

-- the players

dots.players = {
	red = { score = 0 },
	yellow = { score = 0 }
}

dots.currentPlayer = "red"

-- the board

-- board has (LINES-1)*(LINES-1) cells
dots.LINES = 5

-- a 2D array of cell states
dots.cells = {} 
-- also keep track of lines between cells
dots.horizontals = {}
dots.verticals = {}

dots.listeners = {} -- the game scene will register a listener

-- methods

-- reset the board for a new game
function dots:newGame(lines)
	self.listeners = {}
	self.LINES = lines
	self.players.red.score = 0
	self.players.yellow.score = 0

	self.currentPlayer = "red"
	
	self.cells = {}	
	for i = 1, self.LINES-1 do
		self.cells[i] = {}
		for j = 1, self.LINES-1 do
			self.cells[i][j] = { owner = nil }
		end
	end
	
	self.horizontals = {}
	for i = 1, self.LINES do
		self.horizontals[i] = {}
		for j = 1, self.LINES-1 do
			self.horizontals[i][j] = { row = i, col = j, owner = nil }
		end
	end

	self.verticals = {}
	for j = 1, self.LINES do
		self.verticals[j] = {}
		for i = 1, self.LINES-1 do
			self.verticals[j][i] = { row = i, col = j, owner = nil }
		end
	end
end

-- the current player clicks on a horizontal edge
-- precondition: the edge has no owner
function dots:doHorizontal(row, column)
	self.horizontals[row][column].owner = self.currentPlayer
	-- do captures for selecting this edge
	if not self:doHorizontalCapture(row, column) then
		-- no capture
		self:nextPlayer()
	end
end

-- the current player clicks on a vertical edge
-- precondition: the edge has no owner
function dots:doVertical(row, column)
	self.verticals[column][row].owner = self.currentPlayer
	-- do captures for selecting this edge
	if not self:doVerticalCapture(row, column) then
		-- no capture
		self:nextPlayer()
	end
end

-- check if the game is over (all cells captured)
function dots:isOver()
	print("\n Calling is over method")
	return self.players.red.score + self.players.yellow.score == (self.LINES-1)*(self.LINES-1)
end

-- register a listener for captures
function dots:addListener( listener )
	self.listeners[#self.listeners+1] = listener
end

-- switch to the other player
function dots:nextPlayer()
	if self.currentPlayer == "red" then
		self.currentPlayer = "yellow"
	else
		self.currentPlayer = "red"
	end
end

-- capture a cell
function dots:capture( row, column )
	self.cells[row][column].owner = self.currentPlayer
	self.players[self.currentPlayer].score = self.players[self.currentPlayer].score + 1

	-- print(string.format("\n capture player: %s, row: %d, column: %d", self.currentPlayer, row, column))
	for i = 1, #self.listeners do
		self.listeners[i](self.currentPlayer, row, column)
	end
end

-- do captures for this horizontal edge, if any
-- return whether a capture was made
function dots:doHorizontalCapture(row, col)
	local captured = false
	-- check cell above
	if row > 1 then
		if self.verticals[col][row-1].owner and
		   self.horizontals[row-1][col].owner and
		   self.verticals[col+1][row-1].owner then
		   -- cell above is captured
		   self:capture(row-1, col)
		   captured = true
		end
	end
	-- check cell below
	if row < self.LINES then
		if self.verticals[col][row].owner and
		   self.horizontals[row+1][col].owner  and
		   self.verticals[col+1][row].owner then
		   -- cell below is captured
		   self:capture(row, col)
		   captured = true
		end
	end
	return captured 
end

-- do captures for this vertical edge, if any
-- return whether a capture was made
function dots:doVerticalCapture(row, col)
	local captured = false
	-- check cell to left
	if col > 1 then
		if self.verticals[col-1][row].owner and
		   self.horizontals[row][col-1].owner and
		   self.horizontals[row+1][col-1].owner then
		   -- cell to the left is captured
		   self:capture(row, col-1)
		   captured = true
		end
	end
	-- check cell to right
	if col < self.LINES then
		if self.verticals[col+1][row].owner and
		   self.horizontals[row][col].owner and
		   self.horizontals[row+1][col].owner then
		   -- cell to the right is captured
		   self:capture(row, col)
		   captured = true
		end
	end
	return captured 
end

return dots