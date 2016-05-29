local Game = {}

function Game:enter()
	love.graphics.setBackgroundColor(28, 0, 36)

	Player_1 = Player:create("Player 1", 1, 168, Height - 200, 64, 128, "player.png")
	Player_1:load()

	Map:load("test3", "test.png", 10, 5, 0)
	Map:addTileset("test.png", 64, 64, 10, 5)

	-- love.timer.sleep(0.5)
end

function Game:update(dt)
	-- TIME
	Time = love.timer.getTime()

	-- UPDATE
	World_1:update(dt)

end

function Game:draw()
	Renderer:draw("fps")
end

function Game:keypressed(key, scancode, isrepeat)
	if key == "g" then
		Renderer:setRenderDistance(200)
	elseif key == "f" then
		Renderer:setRenderDistance(Width / 2 + 32)
	elseif key == "i" then
		camera:scale(0.9)
	elseif key == "k" then
		camera:scale(1.1)
	end
end

return Game
