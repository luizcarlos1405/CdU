local Tools = {}

-- Trasform game position to Grid position
function Tools.gameToGrid(x, y)
	local Gfac = Gridfactor or 32
	if x then
		Gx   = (x - x % Gfac) or 0
	else
		Gx   = 0
	end
	if y then
		Gy   = (y - y % Gfac) or 0 -- + Height % Gfac
	else
		Gy = 0
	end
	return Gx, Gy
end

function Tools.gridToGame(x, y)
	local Gfac = Gridfactor or 32
	x    = (x - 1) * Gridfactor
	y    = (y - 1) * Gridfactor
	return x, y
end

function Tools.deskToGrid(x, y)
	local Gfac = Gridfactor or 32
	x, y = Push:toGame(x, y)
	x, y = Tools.gameToGrid(x, y)
	return x, y
end

return Tools
