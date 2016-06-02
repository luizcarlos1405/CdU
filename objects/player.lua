local player = collider:rectangle(G_width / 2, G_height - 100, 32, 32)

player.vel      = {x = 0, y = 0}
player.speed    = 200
player.maxvel   = {x = 300, y = 700}
player.minvel   = 0.1
player.gravity  = 150
player.friction = 0.8
player.jump     = 3000
player.jumptime = 0.3
player.fuel     = 0

function player:update(dt)
	-- Controls
	if love.keyboard.isDown("a") then
		self.vel.x = self.vel.x - self.speed
	end
	if love.keyboard.isDown("d") then
		self.vel.x = self.vel.x + self.speed
	end
	if love.keyboard.isDown("space") and self.fuel > 0 then
		self.vel.y = self.vel.y - self.jump * self.fuel
		self.fuel  = self.fuel - dt
		-- self.friction = 1
	end


	-- Frition
	self.vel = {x = self.vel.x * self.friction, y = self.vel.y}

	-- Gravity
	self.vel.y = self.vel.y + self.gravity

	-- Max/min velocity handler
	if math.abs(self.vel.x) > self.maxvel.x then self.vel.x = self.maxvel.x * (math.abs(self.vel.x) / self.vel.x) end
	if math.abs(self.vel.x) < self.minvel then self.vel.x = 0 end
	if math.abs(self.vel.y) > self.maxvel.y then self.vel.y = self.maxvel.y * (math.abs(self.vel.y) / self.vel.y) end

	-- Position atualization
	self:move(self.vel.x * dt, self.vel.y * dt)

	-- Colision handler
	for _, delta in pairs(collider:collisions(self)) do
		self:move(delta.x, delta.y)
		if delta.x == 0 then
			self.vel.y = 0
			self.fuel = self.jumptime
			-- self.friction = 0.8
		end
	end
end

function player:draw()
	-- Get bounding box points
	local x1, y1, x2, y2 = self:bbox()
	-- love.graphics.points(x1, y2)
	love.graphics.rectangle("fill", x1, y1, 32, 32)
end

function player:keypressed(key)
	if key == "space" and self.fuel > 0 then
		self.vel.y = - self.jump
	end
end

function player:keyreleased(key)
	if key == "space" then
		self.fuel = 0
	end
end

return player
