local Platform = {}

function Platform:create(name, posX, posY, w, h)

	local platform = {}
	platform.w       = w or Gridfactor
	platform.h       = h or Gridfactor
	platform.x, platform.y = Tools.toGrid(posX, posY)
	platform.drawing = false
	platform.body    = love.physics.newBody(World, platform.x, platform.y, "static")
	platform.shape   = love.physics.newPolygonShape(0, 0, platform.w, 0, platform.w, platform.h, 0, platform.h)
	platform.fixture = love.physics.newFixture(platform.body, platform.shape)
	platform.fixture:setUserData(name)
	table.insert(Platform, platform)
end

function Platform:destroy()
	local x, y = love.mouse.getPosition()
	local gridx, gridy = Push:toGame(x, y)
	gridx, gridy = Tools.toGrid(gridx, gridy)
	for i,p in ipairs(Platform) do
		if p.x == gridx and p.y == gridy then
			p.fixture:destroy()
			p.body:destroy()
			table.remove(Platform, i)
		end
	end
end

function Platform:update(dt)
	for i, p in ipairs(Platform) do
		if p.drawing then
			local x, y = love.mouse.getPosition()
			p.x, p.y = Push:toGame(x, y)
			p.x, p.y = Tools.toGrid(p.x, p.y)
			p.body:setPosition(p.x, p.y)
			-- self.create("Platform", p.x, p.y)
		end
	end
end

function Platform:draw()
	-- if Platform then
	love.graphics.setColor(28, 175, 166)
		for i, p in ipairs(Platform) do
			love.graphics.rectangle("fill", p.body:getX(), p.body:getY(), p.w, p.h)
		end
	-- end
end

function Platform:mousereleased(x, y, button, isTouch)
	-- for i, p in ipairs(Platform) do
	-- 	if p.drawing then
	-- 		p.drawing = false
	-- 	end
	-- end
end

function Platform:isPlatform()
	local x, y = love.mouse.getPosition()
	local gridx, gridy = Push:toGame(x, y)
	gridx, gridy = Tools.toGrid(gridx, gridy)
	for i,p in ipairs(Platform) do
		if p.x == gridx and p.y == gridy then
			return true
		end
	end
	return false
end

return Platform
