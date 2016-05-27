-- Require everything
require("camera")
Gamestate = require("gamestate")
Timer     = require("timer")
Push      = require("push")
Ser       = require("ser")

-- States
Logos_Screen = require("logos_screen")
Main_Menu    = require("main_menu")

-- Global variables
Screen_Width, Screen_Height = love.window.getDesktopDimensions()
Width, Height               = 1920, 1080
Time_0                      = love.timer.getTime()

function love.load()
	-- Load settings


	-- Screen scalling
	-- love.graphics.setDefaultFilter("nearest", "nearest")
	Push:setupScreen(Width, Height, Screen_Width, Screen_Height, {fullscreen = true, resizable = false})
	Push:setBorderColor{love.graphics.getBackgroundColor()}

	-- Gamestate control from humplib
	Gamestate.registerEvents()
	Gamestate.switch(Logos_Screen)
end

function love.keyreleased(key)
	if key == "escape" then
		love.event.quit("Escaped")
	end
end
