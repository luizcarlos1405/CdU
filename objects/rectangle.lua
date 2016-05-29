local Rect = {}

function Rect:new(x, y, w, h)
	local rect = {}
	
	rect.x = x or 0
	rect.y = y or 0
	rect.w = w or 2
	rect.h = h or 2

	return rect
end

return Rect
