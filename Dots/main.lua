-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Starter for the Dots project
-- Existing code works but needs to be enhanced
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local sfx = require('sfx')

-- Code to initialize the app can go here
composer.setVariable("gridSize", 2)

-- Now load the opening scene

-- Assumes that "questionScene.lua" exists and is configured as a Composer scene
composer.gotoScene( "loadgame" )