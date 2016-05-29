local Player = {}

function Player:create(name, layer, x, y, w, h, img)
	local player = {}

	if img then
		player.img   = love.graphics.newImage("assets/images/"..img)
		player.w = player.img:getWidth()
		player.h = player.img:getHeight()
	else
		player.w     = w or 1
		player.h     = h or 1
	end
	player.name  = name or "A Player has no name"
	player.x     = x or 0
	player.y     = y or 0
	player.r     = 0
	player.scale = {x = 1, y = 1}
	player.ox    = player.w / 2
	player.oy    = player.h / 2
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
		if love.keyboard.isDown("w") then
			player.vel[2] = player.vel[2] - player.acel * dt
		end
		if love.keyboard.isDown("s") then
			player.vel[2] = player.vel[2] + player.acel * dt
		end
		if love.keyboard.isDown("space") then
			player.vel[2] = -player.jump * dt
		end

		-- POSITION UPDATE
		player.x = player.x + player.vel[1]
		player.y = player.y + player.vel[2]
		player.vel = {player.vel[1]*player.fric, player.vel[2]*player.fric}

		-- GRAVITY TEMP
		-- player.vel[2] = player.vel[2] + 300	 * dt

		-- COLISION TEMP
		-- if player.y > Height - player.oy then
		-- 	player.y = Height - player.oy
		-- end

		-- CAMERA FOLLOW
		camera:setPosition(self.x, self.y)

	end

	function player:draw()
		if self.img then
			love.graphics.draw(self.img, self.x, self.y, self.r, self.scale.x, self.scale.y, self.ox, self.oy)
		else
			love.graphics.setColor(213, 29, 230)
			love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		end
	end

	return player

end

return Player
