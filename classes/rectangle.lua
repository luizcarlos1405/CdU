local class = require("tools/class")

Rectangle = class{
	init = function(self, pos, width, heigth, mode)
		self.pos    = pos
		self.width  = width
		self.height = height
		self.mode   = mode or "fill"
	end
	-- speed = 5
}

function Rectangle:draw()
	love.graphics.rectangle(self.mode, self.pos.x - self.width / 2, self.pos.y - self.height / 2, self.width, self.height)
end
