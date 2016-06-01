game = {}

-- Necessary requires
local HC = require("tools/HC")

-- require("classes/rectangle")

function game:enter()
	-- Physics
	collider = HC.new()
		-- Objects
	floor  = collider:rectangle(0, G_height - 20, G_width, 200)
	rect   = collider:rectangle(110, 90, 200, 400)
	rect2  = collider:rectangle(400, 800, 200, 200)
	-- rect = Rectangle.init(rect, {x = 0, y = 0}, 20, 20)
end

function game:update(dt)

	if love.keyboard.isDown("a") then
		rect:move(-10, 0)
	end
	if love.keyboard.isDown("d") then
		rect:move(10, 0)
	end
	if love.keyboard.isDown("space") then
		rect:move(0, -20)
	end
	rect:move(0, 10)

	for _, delta in pairs(collider:collisions(rect)) do
		rect:move(delta.x, delta.y)
	end
end

function game:draw()
	push:apply("start")

	floor:draw()
	rect:draw()
	rect2:draw()

	push:apply("end")
end

return game
