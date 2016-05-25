local Tools = {}

function Tools.toGrid(x, y, Gfac)
	Gfac = Gridfactor or 36
	Gx = x - x % Gfac
	Gy = (y - y % Gfac)-- + Height % Gfac
	return Gx, Gy
end

return Tools
