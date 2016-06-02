game = {}

-- Necessary requires
local world = require("objects/world")
-- require("classes/rectangle")

function game:enter()
	world:load("map1")
end

function game:update(dt)
	player:update(dt)
end

function game:draw()
	push:apply("start")
	
	world:draw()

	push:apply("end")
end

function game:keyreleased(key)
	player:keyreleased(key)
end

function game:keypressed(key)
	player:keypressed(key)
end

return game
