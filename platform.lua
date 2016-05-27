local Platform = {}

Platform.pos = {}

function Platform:create(name, x, y, w, h)
	if Platform:isPlatform(x, y) == false then
		table.insert(Platform.pos, {x, y})
		local platform = {}
		platform.w             = w or 32
		platform.h             = h or Gridfactor
		-- x, y                = Push:toGame(x, y)
		platform.x, platform.y = x, y--Tools.gameToGrid(x, y)
		platform.drawing       = false
		platform.body          = love.physics.newBody(World, platform.x, platform.y, "static")
		platform.shape         = love.physics.newPolygonShape(0, 0, platform.w, 0, platform.w, platform.h, 0, platform.h)
		platform.fixture       = love.physics.newFixture(platform.body, platform.shape)
		platform.fixture:setUserData(name)
		table.insert(Platform, platform)
	end
end

function Platform:destroy()
	local x, y = love.mouse.getPosition()
	local gridx, gridy = Push:toGame(x, y)
	gridx, gridy = Tools.gameToGrid(gridx, gridy)
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
			p.x, p.y = Tools.gameToGrid(p.x, p.y)
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

function Platform:isPlatform(x, y)
	-- local gridx, gridy = Push:toGame(x, y)
	-- gridx, gridy = Tools.gameToGrid(gridx, gridy)
	for i,p in ipairs(Platform) do
		if p.x == x and p.y == y then
			return true
		end
	end
	return false
end

return Platform
