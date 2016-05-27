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
		Button:create("Platform", Tools.deskToGrid(love.mouse.getPosition()))
	elseif to == "Eraser" then
		for i = 1, #Button do
			if Button[i] then
				if Button[i].name == "Platform" then
					table.remove(Button, i)
				end
			end
		end
		Button:create("Erase", Tools.deskToGrid(love.mouse.getPosition()))
	end
end

function Drawing:update(dt)
	if Drawing.state == "Create Platform" then
		for i, b in ipairs(Button) do
			-- If it's a button for creating platforms
			if love.mouse.isDown(1) then
				Platform:create("Platform", Tools.deskToGrid(love.mouse.getPosition()))
				-- Drawing.state = "Create Platform"
			end

			-- Set it's position to the mouse
			if b.name == "Platform" then
				b.x, b.y = Tools.deskToGrid(love.mouse.getPosition())
			end
		end
	elseif Drawing.state == "Eraser" then
		for i, b in ipairs(Button) do
			if Platform:isPlatform(Tools.deskToGrid(love.mouse.getPosition())) and love.mouse.isDown(1) then
				Platform:destroy()
			end

			-- Set it's position to the mouse
			if b.name == "Erase" then
				b.x, b.y = Tools.deskToGrid(love.mouse.getPosition())
			end
		end
	end
end

return Drawing
