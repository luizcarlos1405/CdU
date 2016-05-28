local Game = {}

function Game:enter()
	love.graphics.setBackgroundColor(28, 0, 36)

	Player_1 = Player:create("Player 1", 1, 50, Height - 200, 64, 128)
	Player_1:load()
end

function Game:update(dt)
	-- TIME
	Time = love.timer.getTime()

	-- UPDATE
	World_1:update(dt)

end

function Game:draw()
	Renderer:draw()
end

return Game
