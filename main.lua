-- Requires

local gamestate = require("tools/gamestate")
local game      = require("states/game")
push      = require("tools/push")
-- camera    = require("tools/camera")
-- signal    = require("tools/singal")
-- class     = require("tools/class")
-- timer     = require("tools/timer")
-- vec       = require("tools/vector")

-- Global variables

G_screenWidth     =	love.graphics.getWidth()
G_screeHeigth     = love.graphics.getHeight() --love.window.getDesktopDimensions()
G_width, G_height = 1920, 1080
Time_0            = love.timer.getTime()

function love.load()
	-- Screen scalling
	-- love.graphics.setDefaultFilter("nearest", "nearest")
	push:setupScreen(G_width, G_height, G_screenWidth, G_screeHeigth, {fullscreen = false, resizable = false})
	push:setBorderColor{love.graphics.getBackgroundColor()}

	gamestate.registerEvents()
	gamestate.switch(game)
end


function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		love.event.quit("Escaped")
	end
end
