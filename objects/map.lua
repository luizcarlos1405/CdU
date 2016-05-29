local Map = {}

function Map:load(mapname, w_tiles, h_tiles, spacing)
	self.map        = require("maps/"..mapname)
	self.tilesets   = {}
	self.quads      = {}
	self.width      = self.map.width * self.map.tilewidth
	self.height     = self.map.height * self.map.tileheight
	self.tilewidth  = self.map.tilewidth
	self.tileheight = self.map.tileheight
	Tiles           = {} -- Global

	-- Make coordinate sistem
	for layer = 1, #self.map.layers do
		Tiles[layer] = {}  -- Global
		Tiles[layer].colision = self.map.layers[layer].properties["colision"]
		-- for x = 1, self.map.width do
		-- 	self.map.layers[layer][x] = {}
		-- 	for y = 1, self.map.height do
		-- 		self.map.layers[layer][x][y] = {}
		-- 	end
		-- end
	end

	Renderer:add(self)
	World_1:add(self)

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
	-- Calculate only once
	-- local pX      = math.abs(Player_1.x - (self.map.tilewidth / 2))
	-- local pY      = math.abs(Player_1.y - (self.map.tileheight / 2))
	--
	-- for layer = 1, #Tiles do
	-- 	for i, t in ipairs(Tiles[layer]) do
	-- 		if pX - t.x < Player_1.colX and pY - t.y < Player_1.colY then
	-- 			if Player_1.x + Player_1.ox > t.x and Player_1.x - Player_1.ox < t.x + t.w and
	-- 			Player_1.y + Player_1.oy > t.y and Player_1.y - Player_1.oy < t.y + t.h then
	-- 				if self.map.layers[layer].properties["colision"] then
	-- 					-- Player_1.y = Player_1.y - Player_1.y + Player_1.oy - t.y
	-- 					print("COLISION	")
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end
end

function Map:draw()
	-- Calculate only once
	-- local pX      = math.abs(Player_1.x + (Player_1.w / 2))
	-- local pY      = math.abs(Player_1.y + (Player_1.h / 2))
	local cammaxX = Width + self.tilewidth
	local cammaxY = Height + self.tileheight

	for layer = 1, #Tiles do
		for x = 1, #Tiles[layer] do
			for i, t in ipairs(Tiles[layer][x]) do
				if t then
				-- if camera.x > 0 and camera.y > 0 and camera.x < cammaxX and camera.y < cammaxY then
				-- 	-- BASED ON PLAYER POSITION
				-- 	if math.abs(Player_1.x - t.x) < Renderer.Xdistance and math.abs(Player_1.y - t.y) < Renderer.Ydistance then
				-- 		love.graphics.draw(Tilesets[t.tileset], self.quads[t.quad], t.x, t.y)
				-- 		-- love.graphics.draw(img, top_left, 50, 50)
				-- 		love.graphics.print(layer, t.x, t.y)
				-- 	end
				-- else
					-- BASED ON CAMERA POSITION
					if t.x >= camera.x - self.tilewidth and t.x <= camera.x + cammaxX and t.y >= camera.y - self.tileheight and t.y <= camera.y + cammaxY then
						love.graphics.draw(self.tilesets[t.tileset], self.quads[t.quad], t.x, t.y)
						love.graphics.print(layer.." "..x.." "..i, t.x, t.y)
					end
				-- end
				end
			end
		end
	end
	-- Escolha a posição que quer marcar
	-- love.graphics.print("AQUI!!!!!!!!!!", Tiles[1][28][18].x, Tiles[1][28][18].y + 20)
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
	for layer = 1, #Tiles do
		data = self.map.layers[layer].data
		for x = 1, self.map.width do
			Tiles[layer][x] = {}
			for y = 1, self.map.height do
				-- Index
				i = (y - 1) * self.map.width + x

				Tiles[layer][x][y] = {}
				if data[i] > 0 then
					tile = Tile:new(x * self.map.tilewidth - self.map.tilewidth, y * self.map.tileheight - self.map.tileheight, self.map.tilewidth, self.map.tileheight, data[i], #self.tilesets)
					Tiles[layer][x][y] = tile
				else
					Tiles[layer][x][y] = false
				end
			end
		end
	end
end

function  Map:getTiles()
	return Tiles
end

return Map
