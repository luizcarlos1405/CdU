-- Require everything
require("camera")
Ser       = require("ser")
Push      = require("push")
Gamestate = require("gamestate")
Timer     = require("timer")
Platform  = require("platform")
Button    = require("button")
Player    = require("player")
Tools     = require("tools")
Drawing   = require("drawing")

-- States
Logos_Screen = require("logos_screen")
Main_Menu    = require("main_menu")
Game         = require("game")

-- Global variables
Time_0                      = love.timer.getTime()
Screen_Width, Screen_Height = love.window.getDesktopDimensions()
Width, Height               = 1920, 1080

function love.load()
	-- Load settings


	-- Screen scalling
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
