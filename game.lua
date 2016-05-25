local Game = {}

text = ""

function Game:enter()
	love.graphics.setBackgroundColor(1, 0, 30)
	Gridfactor = 32

	-- Fonts
	outwrite_100 = love.graphics.newFont("assets/fonts/outwrite.ttf", 100)
	ecran_100    = love.graphics.newFont("assets/fonts/ecran-monochrome.ttf", 100)
	ecran_40     = love.graphics.newFont("assets/fonts/ecran-monochrome.ttf", 40)
	love.graphics.setFont(ecran_40)

	-- Create world for physics
	World = love.physics.newWorld(0, 1500, true)
	World:setCallbacks(beginContact, endContact, preSolve, postSolve)
	love.physics.setMeter(64)

	-- BORDER
	-- Border = {}
	-- Border.body    = love.physics.newBody(World, 0, 0, "static")
	-- Border.shape   = love.physics.newChainShape(true, 0, (Height) + 1, 0, 0, Width + 1, 0, Width + 1, Height + 1)
	-- Border.fixture = love.physics.newFixture(Border.body, Border.shape)
	-- Border.fixture:setUserData("Border")

	-- BALL
	Ball         = {}
	Ball.r       = 16
	Ball.x       = 80
	Ball.y       = Ball.x
	Ball.body    = love.physics.newBody(World, Ball.x, Ball.y, "dynamic")
	Ball.shape   = love.physics.newCircleShape(Ball.r)
	Ball.fixture = love.physics.newFixture(Ball.body, Ball.shape)
	Ball.fixture:setRestitution(0.9)
	-- ENDBALL

	-- Load Player
	Player:load()

	-- Set Platforms
	Platform:create("Fixed Platform", 0, 1064, Width, nil)
	-- Platform:create("Platform", 40, 900, nil, nil)

	-- Set Buttons
	Button:create("Create Platform", Width - 37, 40)
	Button:create("Eraser", Width - 37, 120)
end

function Game:update(dt)
	-- Update the World
	World:update(dt)
	-- Update everything else
	-- Platform:update(dt)
	Player:update(dt)
	Button:update(dt)
	Drawing:update(dt)
end

function Game:draw()

	-- Starts screen scalling
	Push:apply("start")

	-- GRID
	for i = 0, Width do
		love.graphics.line(i * Gridfactor, 0, i * Gridfactor, Height)
	end
	for i = 0, Height do
		love.graphics.line(0, i * Gridfactor, Width, i * Gridfactor)
	end

	Platform:draw()
	Player:draw()
	Button:draw()

	if text then
		love.graphics.print(#Button.."\n"..#Platform.." "..Player.body:getLinearVelocity()..
		"\n"..Drawing.state)
	end

	-- BALL
	love.graphics.setColor(214, 223, 46)
	love.graphics.circle("fill", Ball.body:getX(), Ball.body:getY(), Ball.r)
	-- ENDBALL

	-- Ends screen scalling
	Push:apply("end")
end

-- TODO(Luiz): clear everything when exiting state

-- MOUSE

function love.mousepressed(x, y, button, isTouch)
	click_x, click_y = Push:toGame(x, y)
	Button:mousepressed(click_x, click_y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
	Button:mousereleased(x, y, button, isTouch)
	Platform:mousereleased(x, y, button, isTouch)
end

-- KEYBOARD

function love.keypressed(key, scancode, isrepeat)
	Player:keypressed(key)
end

-- COLISIONS

function beginContact(fa, fb, coll)
	-- if fa == Border.fixture or fa == Border.fixture then
	-- 	if fa == Player.fixture or fb == Player.fixture then
	-- 		Player.onfloor = true
	-- 		text = "on floor"
	-- 	end
	-- end
end

function endContact(fa, fb, coll)
	if fa == Player.fixture or fb == Player.fixture then
	if fa:getUserData() == "Platform" or "Border" or fb:getUserData() == "Platform" or "Border" then
			Player.onfloor = false
		end
	end
end

function preSolve(fa, fb, coll)
	if fa == Player.fixture or fb == Player.fixture then
		if fa:getUserData() == "Platform" or "Border" or fb:getUserData() == "Platform" or "Border" then
			if Player.onfloor == false then
				Player.onfloor = true
			end
		end
	end
end

function postSolve(fa, fb, coll, normalimpulse, tangentimpulse)

end

return Game
