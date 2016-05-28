local Main_Menu = {}

function Main_Menu:enter()
	love.graphics.setBackgroundColor(0, 4, 94)

	-- Fonts
	outwrite_100 = love.graphics.newFont("assets/fonts/outwrite.ttf", 100)
	ecran_100    = love.graphics.newFont("assets/fonts/ecran-monochrome.ttf", 100)
	play         = love.graphics.newText(ecran_100, "Enter to play")
end

function Main_Menu:draw()
	-- Starts screen scalling
	Push:apply("start")

	love.graphics.draw(play, Width / 2, Height / 2, 0, 1, 1, play:getWidth()/2, play:getHeight()/2)

	-- Ends screen scalling
	Push:apply("end")
end

function Main_Menu:keypressed(key)
	if key == "return" then
		-- TODO(Luiz): create game gamestate
		Gamestate.switch(Game)
	end
end

return Main_Menu
