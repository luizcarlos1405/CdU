local player = collider:rectangle(G_width / 2, G_height - 100, 32, 32)

player.vel      = {x = 0, y = 0}
player.speed    = 200
player.maxvel   = 2000
player.gravity  = 10
player.friction = 0.8
player.jump     = 1000
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
	-- if love.keyboard.isDown("space") and self.fuel > 0 then
	-- 	self.vel.y = self.vel.y - self.jump * 0.2
	-- 	self.fuel  = self.fuel - dt
	-- 	self.friction = 1
	-- end


	-- Frition
	self.vel = {x = self.vel.x * self.friction, y = self.vel.y}

	-- Gravity
	self.vel.y = self.vel.y + self.gravity
	if math.abs(self.vel.x) > self.maxvel then self.vel.x = self.maxvel * (math.abs(self.vel.x) / self.vel.x) end
	if math.abs(self.vel.y) > self.maxvel then self.vel.y = self.maxvel * (math.abs(self.vel.y) / self.vel.y) end

	-- Position atualization
	self:move(self.vel.x * dt, self.vel.y * dt)

	-- Colision handler
	for _, delta in pairs(collider:collisions(self)) do
		self:move(delta.x, delta.y)
		if delta.x == 0 then
			self.vel.fuel = 0
			self.fuel = self.jumptime
			-- self.friction = 0.8
		end
	end
end

function player:draw()
	local x1, y1, x2, y2 = self:bbox()
	love.graphics.points(x1, x2)
	love.graphics.rectangle("fill", x1, y1, 32, 32)
end

function player:keyreleased(key)
	if key == "space" then
		self.fuel = 0
	end
end

function player:keypressed(key)
	if key == "space" then
		self.vel.y = - self.jump
	end
end

return player
