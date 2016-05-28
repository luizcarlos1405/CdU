local Map = {}

function Map:load(mapname, tileset, w_tileset, h_tileset, spacing)
	local map    = require("maps/"..mapname)
	self.tileset = love.graphics.newImage("assets/images/"..tileset)
	self.quads   = Tile:extractQuads(self.tileset, map.tilewidth, map.tileheight, w_tileset, h_tileset, spacing)
	self.tiles    = {}

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
end

function Map:draw()
		for i, t in ipairs(self.tiles) do
			if math.abs(Player_1.x - t.x) < 200 and math.abs(Player_1.y - t.y) < 200 then
				love.graphics.draw(self.tileset, self.quads[t.quad], t.x, t.y)
				-- love.graphics.draw(img, top_left, 50, 50)
			end
		end
end

return Map
