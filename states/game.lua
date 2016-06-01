game = {}

-- Necessary requires

-- require("classes/rectangle")

function game:enter()
	-- Physics
	HC = require("tools/HC")
	collider = HC.new()

		-- Objects
	player = require("objects/player")
	floor  = collider:rectangle(0, G_height - 20, G_width, 200)
	-- rect = Rectangle.init(rect, {x = 0, y = 0}, 20, 20)
end

function game:update(dt)
	player:update(dt)

end

function game:draw()
	push:apply("start")

	floor:draw("fill")
	player:draw("fill")

	push:apply("end")
	love.graphics.print(player.vel)
end

function game:keyreleased(key)
	player:keyreleased(key)
end

return game
