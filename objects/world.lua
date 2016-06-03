local world = {}

-- Physics
local HC = require("tools/HC")
collider = HC.new()
Camera   = require("humplib/camera")

function world:load(mapname)
	-- Objects
	player = require("objects/player")
	camera = Camera(G_width / 2, G_height / 2)

	self:setMap(mapname)

end

function world:update(dt)


end

function world:draw()
  	camera:attach()
	local x, y, a, b = player:bbox()
	camera.x = x
	camera.y = y

    world:drawMap()
	player:draw("fill")
	love.graphics.print(love.timer.getFPS())
	love.graphics.print(#self.quads, 50, 50)
	camera:detach()
end

-- Prepare map geting quads and makind the grid, also sets player position
function world:setMap(mapname)
	-- Load map
	self.map = require("maps/"..mapname)
	love.graphics.setBackgroundColor(self.map.backgroundcolor[1], self.map.backgroundcolor[2], self.map.backgroundcolor[3])

	-- Extract quads and put'em into a table. Only works for png images
	-- Also create tiles objects and create the grid with'em
	self.quads = {}
	self.tilesets = {}
	for i = 1, #self.map.tilesets do
		local tileset = love.graphics.newImage("assets/tilesets/"..self.map.tilesets[i].name..".png")
		local quads   = self:extractQuads(tileset, self.map.tilesets[i].spacing, self.map.tilesets[i].properties["w_tiles"], self.map.tilesets[i].properties["h_tiles"])
        table.insert(self.tilesets, tileset)

		-- Put quad by quad into the table, this way the index of the quad will
		-- be equal to the index on the tiled map file
		for j = 1, #quads do
      		local quad   = {}
      		quad.q       = quads[j]
      		quad.tileset = i
			table.insert(self.quads, quad)
		end
	end

	-- Create physics for the tiles in the layers that should collide
	self.colliders = {}
	for layer = 1, #self.map.layers do
    	if self.map.layers[layer].properties["collision"] then
      		for index = 1, #self.map.layers[layer].data do
				if self.map.layers[layer].data[index] > 0 then
        			local x, y = self:indexToGrid(index)
                    local coll = collider:rectangle(x * self.map.tilewidth - self.map.tilewidth, y * self.map.tileheight - self.map.tileheight, self.map.tilewidth, self.map.tileheight)
					table.insert(self.colliders, coll)
                end
        	end
      	end
    end

	-- Temporary player position
  	player:moveTo(100, 100)
end

function world:drawMap()
	for layer = 1, #self.map.layers do
    	for index = 1, #self.map.layers[layer].data do
			if self.quads[self.map.layers[layer].data[index]] then
        		local quad = self.quads[self.map.layers[layer].data[index]]
        		local x, y = self:indexToGrid(index)
      			--love.graphics.print(x.." "..y, x * self.map.tilewidth - self.map.tilewidth, y * self.map.tileheight - self.map.tileheight)
   				love.graphics.draw(self.tilesets[quad.tileset], quad.q, x * self.map.tilewidth - self.map.tilewidth, y * self.map.tileheight - self.map.tileheight)
			end
        end
	end
end

function world:indexToGrid(index)
	local x, y = (index % self.map.width), math.ceil(index / self.map.width)
	if x == 0 then x = self.map.width end
	return x, y
end

function world:gridToIndex(x, y)
	local index = (y - 1) * self.map.width + x
  	return index
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

return world
