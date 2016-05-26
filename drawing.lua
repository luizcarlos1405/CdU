local Drawing = {}

Drawing.state = "Nothing"

function Drawing:changeState(to)
	Drawing.state = to or "Nothing"
	if to == "Create Platform" then
		for i = 1, #Button do
			if Button [i] then
				if Button[i].name == "Erase" then
					table.remove(Button, i)
				end
			end
		end
		local click_x, click_y = love.mouse.getPosition()
		Button:create("Platform", click_x, click_y)
	elseif to == "Eraser" then
		for i = 1, #Button do
			if Button [i] then
				if Button[i].name == "Platform" then
					table.remove(Button, i)
				end
			end
		end
		local click_x, click_y = love.mouse.getPosition()
		Button:create("Erase", click_x, click_y)
	end
end

function Drawing:update(dt)
	if Drawing.state == "Create Platform" then
		for i, b in ipairs(Button) do
			-- If it's a button for creating platforms
			if love.mouse.isDown(1) then
				Platform:create("Platform", love.mouse.getPosition())
				-- Drawing.state = "Create Platform"
			end

			-- Set it's position to the mouse
			if b.name == "Platform" then
				local x, y = love.mouse.getPosition()
				b.x, b.y = Push:toGame(x, y)
				b.x, b.y = Tools.toGrid(b.x, b.y)
			end
		end
	elseif Drawing.state == "Eraser" then
		for i, b in ipairs(Button) do
			if Platform:isPlatform(love.mouse.getPosition()) and love.mouse.isDown(1) then
				Platform:destroy()
			end

			-- Set it's position to the mouse
			if b.name == "Erase" then
				local x, y = love.mouse.getPosition()
				b.x, b.y = Push:toGame(x, y)
				b.x, b.y = Tools.toGrid(b.x, b.y)
			end
		end
	end
end

return Drawing
