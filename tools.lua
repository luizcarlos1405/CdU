local Tools = {}

-- Trasform game position to Grid position
function Tools.toGrid(x, y)
	Gfac = Gridfactor or 32
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

return Tools
