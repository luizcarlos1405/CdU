local Map = {}

function Map:load(mapname, tileset, w_tileset, h_tileset, spacing)
	local map       = require("maps/"..mapname)
	self.tileset    = love.graphics.newImage("assets/images/"..tileset)
	self.quads      = Tile:extractQuads(self.tileset, map.tilewidth, map.tileheight, w_tileset, h_tileset, spacing)
	self.tiles      = {}
	self.width      = map.width * map.tilewidth
	self.height     = map.height * map.tileheight
	self.tilewidth  = map.tilewidth
	self.tileheight = map.tileheight

	local i, data = 0, 0
	local tile    = {}
	for layer = 1, #map.layers do
		data = map.layers[layer].data
		for y = 1, map.height do
			for x = 1, map.width do
				i = (y - 1) * map.width + x
				if data[i] > 0 then
					tile = Tile:new(x * map.tilewidth - map.tilewidth, y * map.tileheight - map.tileheight, map.tilewidth, map.tileheight, data[i])
					table.insert(self.tiles, tile)
				end
			end
		end
	end

	Renderer:add(self)
	World_1:add(self)

	fat = 0
	xfat = Renderer.Xdistance
	yfat = Renderer.Ydistance
end

function Map:update(dt)
	-- Don't let camera go out the map
	if camera.x < 0 then
		camera.x = 0
	end
	if camera.y < 0 then
		camera.y = 0
	end
	if camera.x > self.width - Width then
		camera.x = self.width - Width
	end
	if camera.y > self.height - Height then
		camera.y = self.height - Height
	end

	-- EFEITO PARA DEMONSTRAÇÃO, APAGAR SE QUISER DESATIVAR
	-- FAZ A ÁREA DE DESENHO VARIAR
	fat = fat + dt
	Renderer.Ydistance = math.abs(yfat * math.cos(fat))
	Renderer.Xdistance = math.abs(xfat * math.cos(fat))
end

function Map:draw()
	for i, t in ipairs(self.tiles) do
		-- if camera.x > 0 and camera.y > 0 and camera.x < Width + self.tilewidth and camera.y < Height + self.tileheight then
			-- BASED ON PLAYER POSITION
			if math.abs(Player_1.x - t.x - (t.w / 2)) < Renderer.Xdistance and math.abs(Player_1.y - t.y - (t.h / 2)) < Renderer.Ydistance then
				love.graphics.draw(self.tileset, self.quads[t.quad], t.x, t.y)
				-- love.graphics.draw(img, top_left, 50, 50)
			end
		-- else
		-- 	-- BASED ON CAMERA POSITION
		-- 	if t.x >= camera.x - self.tilewidth and t.x <= camera.x + Width + self.tilewidth and t.y >= camera.y - self.tileheight and t.y <= camera.y + Height + self.tileheight then
		-- 		love.graphics.draw(self.tileset, self.quads[t.quad], t.x, t.y)
		-- 	end
		-- end
	end
end

return Map
