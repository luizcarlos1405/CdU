local world = {}

-- Physics
local HC = require("tools/HC")
collider = HC.new()

function world:load(mapname)
	-- Objects
	player = require("objects/player")
	floor  = collider:rectangle(0, G_height - 20, G_width, 200)

	self:setMap(mapname)

end

function world:update(dt)


end

function world:draw()
	floor:draw("fill")
	player:draw("fill")

	love.graphics.print(love.timer.getFPS())
	love.graphics.print(#self.quads, 50, 50)
end

-- Prepare map geting quads and makind the grid, also sets player position
function world:setMap(mapname)
	-- Load map
	self.map = require("maps/"..mapname)
	love.graphics.setBackgroundColor(self.map.backgroundcolor[1], self.map.backgroundcolor[2], self.map.backgroundcolor[3])

	-- Extract quads and put'em into a table. Only works for png images
	-- Also create tiles objects and create the grid with'em
	self.quads = {}
	self.tiles = {}
	for i = 1, #self.map.tilesets do
		local tileset = love.graphics.newImage("assets/tilesets/"..self.map.tilesets[i].name..".png")
		local quads = self:extractQuads(tileset, self.map.tilesets[i].spacing, self.map.tilesets[i].properties["w_tiles"], self.map.tilesets[i].properties["h_tiles"])

		-- Put quad by quad into the table, this way the index of the quad will
		-- be equal to the index on the tiled map file
		for j = 1, #quads do
			quads[j].tileset = i
			table.insert(self.quads, quads)
		end
	end
	print(self.quads[2].tileset)
end

-- Extract all quads from a tileset and return a table with them
function world:extractQuads(tileset, spacing, w_tiles, h_tiles)
	-- w_tiles is the number of tiles horizontally on the tileset
	-- h_tiles is the number of tiles vertically on the tileset
	local quads   = {}
	local spacing = spacing or 0
	local x, y    = 0, 0

	-- extract all the quads considering spacing
	for i = 1, h_tiles do
		y = (i - 1) * self.map.tileheight + (i * spacing)
		for j = 1, w_tiles do
			x = (j - 1) * self.map.tilewidth + (j * spacing)
			local quad = love.graphics.newQuad(x, y, self.map.tilewidth, self.map.tileheight, tileset:getDimensions())
			table.insert(quads, quad)
		end
	end
	return quads
end

function world:drawMap()
	for layer = 1, #self.map.layers do

	end

end

return world
