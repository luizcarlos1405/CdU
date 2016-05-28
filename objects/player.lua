local Player = {}

function Player:create(name, layer, x, y, w, h)
	local player = {}

	player.name  = name or "A Player has no name"
	player.x     = x or 0
	player.y     = y or 0
	player.w     = w or 1
	player.h     = h or 1
	player.jump  = 2000
	player.acel  = 150
	player.vel   = {0, 0}
	player.fric  = 0.7
	player.layer = layer or 1

	function player:load()
		Renderer:add(self, layer)
		World_1:add(self)
	end

	function player:update(dt)
		-- CONTROLS
		if love.keyboard.isDown("a") then
			player.vel[1] = player.vel[1] - player.acel * dt
		end
		if love.keyboard.isDown("d") then
			player.vel[1] = player.vel[1] + player.acel * dt
		end
		if love.keyboard.isDown("space") then
			player.vel[2] = -player.jump * dt
		end

		-- POSITION UPDATE
		player.x = player.x + player.vel[1]
		player.y = player.y + player.vel[2]
		player.vel = {player.vel[1]*player.fric, player.vel[2]*player.fric}

		-- GRAVITY TEMP
		player.vel[2] = player.vel[2] + 300	 * dt

		-- COLISION TEMP
		if player.y > Height - player.h then
			player.y = Height - player.h
		end

	end

	function player:draw()
		love.graphics.setColor(213, 29, 230)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	end

	return player

end

return Player
