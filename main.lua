-- Global variables

Screen_Width  =	love.graphics.getWidth()
Screen_Height = love.graphics.getHeight()--love.window.getDesktopDimensions()
Width, Height = 1920, 1080
Time_0        = love.timer.getTime()

-- Require everything
require("tools/camera")
require("tools/physics")	
Ser       = require("tools/ser")
Push      = require("tools/push")
Timer     = require("tools/timer")
Render    = require("tools/renderer")
Gamestate = require("tools/gamestate")
Player    = require("objects/player")
Tile      = require("objects/tile")
Map       = require("objects/map")
World     = require("world")

-- States
Logos_Screen = require("gamestates/logos_screen")
Main_Menu    = require("gamestates/main_menu")
Game         = require("gamestates/game")

function love.load()
	-- Load settings
	Renderer = Render:create("nearest", "linear", 64, 64)
	World_1  = World:create()

	-- Screen scalling
	-- love.graphics.setDefaultFilter("nearest", "nearest")
	Push:setupScreen(Width, Height, Screen_Width, Screen_Height, {fullscreen = false, resizable = false})
	Push:setBorderColor{love.graphics.getBackgroundColor()}

	-- Gamestate control from humplib
	Gamestate.registerEvents()
	Gamestate.switch(Logos_Screen)
end

function love.resize(w, h)
	print("Resized")
end

function love.keyreleased(key)
	if key == "escape" then
		love.event.quit("Escaped")
	end
end
