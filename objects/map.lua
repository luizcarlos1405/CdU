local Map = {}

function Map:load(mapname, w_tiles, h_tiles, spacing)
	self.map        = require("maps/"..mapname)
	self.tilesets   = {}
	self.quads      = {}
	self.tiles      = {}
	self.width      = self.map.width * self.map.tilewidth
	self.height     = self.map.height * self.map.tileheight
	self.tilewidth  = self.map.tilewidth
	self.tileheight = self.map.tileheight

	Renderer:add(self)
	World_1:add(self)

	-- fat = 0
	-- xfat = Renderer.Xdistance
	-- yfat = Renderer.Ydistance
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

	-- COLISION
	for layer = 1, #self.tiles do
		for i, t in ipairs(self.tiles[layer]) do
			if math.abs(Player_1.x - t.x - (t.w / 2)) < Renderer.Xdistance and math.abs(Player_1.y - t.y - (t.h / 2)) < Renderer.Ydistance then
				if Player_1.x > t.x and Player_1.x < t.x + t.w and Player_1.y > t.y and Player_1.y < t.y + t.h then
					if layer == 1 then
						Player_1.x = Player_1.x + 1
					end
				end
			end
		end
	end
	-- EFEITO PARA DEMONSTRAÇÃO, APAGAR SE QUISER DESATIVAR
	-- FAZ A ÁREA DE DESENHO VARIAR
	-- fat = fat + dt
	-- Renderer.Ydistance = math.abs(yfat * math.cos(fat))
	-- Renderer.Xdistance = math.abs(xfat * math.cos(fat))
end

function Map:draw()
	for layer = 1, #self.tiles do
		for i, t in ipairs(self.tiles[layer]) do
			if camera.x > 0 and camera.y > 0 and camera.x < Width + self.tilewidth and camera.y < Height + self.tileheight then
				-- BASED ON PLAYER POSITION
				if math.abs(Player_1.x - t.x - (t.w / 2)) < Renderer.Xdistance and math.abs(Player_1.y - t.y - (t.h / 2)) < Renderer.Ydistance then
					love.graphics.draw(self.tilesets[t.tileset], self.quads[t.quad], t.x, t.y)
					-- love.graphics.draw(img, top_left, 50, 50)
					love.graphics.print(layer, t.x, t.y)
				end
			else
				-- BASED ON CAMERA POSITION
				if t.x >= camera.x - self.tilewidth and t.x <= camera.x + Width + self.tilewidth and t.y >= camera.y - self.tileheight and t.y <= camera.y + Height + self.tileheight then
					love.graphics.draw(self.tilesets[t.tileset], self.quads[t.quad], t.x, t.y)
					love.graphics.print(layer, t.x, t.y)
					-- love.graphics.print("              "..t.tilset.." "..#self.quads, Player_1.x, Player_1.y)
				end
			end
		end
	end
end

function Map:addTileset(tileset, width, height, w_tiles, h_tiles, spacing)
	tileset = love.graphics.newImage("assets/images/"..tileset)
	local temp_quads = Tile:extractQuads(tileset, width, height, w_tiles, h_tiles, spacing)
	for i = 1, #temp_quads do
		table.insert(self.quads, temp_quads[i])
	end
	table.insert(self.tilesets, tileset)

	local i, data = 0, 0
	local tile    = {}
	for layer = 1, #self.map.layers do
		data = self.map.layers[layer].data
		self.tiles[layer] = {}
		for y = 1, self.map.height do
			for x = 1, self.map.width do
				i = (y - 1) * self.map.width + x
				if data[i] > 0 then
					tile = Tile:new(x * self.map.tilewidth - self.map.tilewidth, y * self.map.tileheight - self.map.tileheight, self.map.tilewidth, self.map.tileheight, data[i], #self.tilesets)
					table.insert(self.tiles[layer], tile)
				end
			end
		end
	end
end

return Map
