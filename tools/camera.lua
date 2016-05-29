camera           = {}
camera.x         = 0
camera.y         = 0
camera.scaleX    = 1
camera.scaleY    = 1
camera.rotation  = 0
camera.transW    = Width / 2
camera.transH    = Height / 2

function camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self.x, -self.y)

end

function camera:unset()
	love.graphics.pop()
end

function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
	love.graphics.translate(self.transW, self.transH)
	self.rotation = self.rotation + dr
	love.graphics.translate(- self.transW, - self.transH)
end

function camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
	self.x = (x - self.transW * self.scaleX) or self.x
	self.y = (y - self.transH * self.scaleY) or self.y
end

function camera:setAngle(a)
	self.rotation = a
	length = ((self.transW) ^ 2 + (self.transH) ^ 2) ^ (1 / 2)
end

function camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end
