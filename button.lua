local Button = {}

function Button:create(name, posX, posY, w, h)

	local button = {}
	-- If it should follow mouse
	if name == "Platform" then
		button.drawing = true
	elseif name == "Erase" then
		button.drawing = true
	else
		button.drawing = false
	end

	if posX and posY then
		button.w           = w or Gridfactor
		button.h           = h or Gridfactor
		posX, posY         = Push:toGame(posX, posY)
		button.x, button.y = Tools.gameToGrid(posX, posY)
		button.name        = name or "Button"
		table.insert(Button, button)
	end

	-- button.body    = love.physics.newBody(World, button.x + button.w / 2, button.y + button.h / 2, "static")
	-- button.shape   = love.physics.newRectangleShape(button.w, button.h)
	-- button.fixture = love.physics.newFixture(button.body, button.shape)
	-- button.fixture:setUserData(name)
end

function Button:destroy(posX, posY)

end

function Button:update(dt)

end

function Button:draw()
	for i, b in ipairs(Button) do
		love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
	end
end

function Button:mousepressed(x, y, button, isTouch)
	Button:isPressed(x, y)
end

function Button:mousereleased(x, y, button, isTouch)
	-- click_x, click_y = Push:toGame(x, y)
	-- for i, b in ipairs(Button) do
	-- 	if b.drawing then
	-- 		b.drawing = false
	-- 	end
	-- end
end

function Button:isPressed(x, y)
	if x and y then
		for i, b in ipairs(Button) do
			if x >= b.x and x <= b.x + b.w then
				if y >= b.y and y <= b.y + b.h then
					-- If a button to create platform is pressed
					if b.name ~= "Erase" and b.name ~= "Platform" then
						Drawing:changeState(b.name)
						return b.name or "Some error here!"
					end
				end
			end
		end
	end
	return "Nothing"
end

function Button:isButton(x, y)
	local x, y = love.mouse.getPosition()
	local gridx, gridy = Push:toGame(x, y)
	gridx, gridy = Tools.gameToGrid(gridx, gridy)

	for i,p in ipairs(Button) do
		if p.x == gridx and p.y == gridy then
			return true
		end
	end
	return false
end

return Button
