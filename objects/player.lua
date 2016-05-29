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
	player.ox    = 0--player.w / 2
	player.oy    = 0--player.h / 2
	player.jump  = 2000
	player.acel  = 150
	player.vel   = {0, 0}
	player.fric  = 0.7
	player.layer = layer or 1
	player.colX  = player.w
	player.colY  = player.h


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

		-- COLLISION
		-- Grid player position
		local x = math.ceil(player.x / 64)
		local y = math.ceil(player.y / 64)
		local w = 1
		local h = 2
		-- Avoid negative values and 0
		if x < 1 then x = 1 end
		if y < 1 then y = 1 end
		-- print(x.." "..y)
		-- Iterate the tiles into collision layers arround the player and aply physics
		for i = x, x + w do
			for j = y, y + h do
				for layer = 1, #Tiles do
					if Tiles[layer].collision then
						local tile = Tiles[layer][i][j]
						if tile then
							if  boxCollision(Player_1, tile) then
								print("COLLISION WITH TILE: "..i..", "..j)
							end
						else
							print("NO COLLISION!")
						end
					end
				end
			end
		end

		-- CAMERA FOLLOW

		-- Hard camera
		camera:setPosition(self.x + self.w / 2, self.y + self.h / 2)
		--

		-- Smoth camera
		-- camera:move(((self.x + self.w / 2) - (camera.x + Width / 2)) * 0.2, ((self.y + self.h / 2) - (camera.y + Height / 2)) * 0.2)
		--

	end

	function player:draw()
		if self.img then
			love.graphics.draw(self.img, self.x, self.y, self.r, self.scale.x, self.scale.y, self.ox, self.oy)
		else
			love.graphics.setColor(213, 29, 230)
			love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		end

		-- BOUNDING BOX
		self.bounding = require("objects/rectangle"):new(self.x, self.y, self.w, self.h)
		love.graphics.line(self.bounding.x, self.bounding.y, self.bounding.x, self.bounding.y + self.bounding.h, self.bounding.x + self.bounding.w, self.bounding.y + self.bounding.h, self.bounding.x + self.bounding.w, self.bounding.y, self.bounding.x, self.bounding.y)
	end

	return player

end

return Player
