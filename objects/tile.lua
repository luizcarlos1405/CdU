local Tile = {}

function Tile:new(x, y, w, h, quad)
	local tile = {}
	tile.x     = x
	tile.y     = y
	tile.w     = w
	tile.h     = h
	tile.quad  = quad

	return tile

end

-- Extract all quads from a tileset and return a table with them
function Tile:extractQuads(tileset, width, height, w_tiles, h_tiles, spacing)
	local quads             = {}
	local spacing           = spacing or 0
	local x, y              = 0, 0

	for i = 1, h_tiles do
		y = (i - 1) * height + (i * spacing)
		for j = 1, w_tiles do
			x = (j - 1) * height + (j * spacing)
			local quad = love.graphics.newQuad(x, y, width, height, tileset:getDimensions())
			table.insert(quads, quad)
		end
	end
	return quads
end

return Tile
