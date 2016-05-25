local Player = {}

function Player:load()
	self.w       = 64
	self.h       = 128
	self.vel     = 200
	self.force   = 6000
	self.jump    = 4000
	self.maxvel  = 500
	self.onfloor = false
	self.body    = love.physics.newBody(World, self.w, self.h, "dynamic")
	self.shape   = love.physics.newRectangleShape(self.w, self.h)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.body:setMass(80)
	self.body:setLinearDamping(4)
	self.body:setFixedRotation(true)
	-- self.fixture:setFriction(1)
	-- self.fixture:setRestitution(0.3)
end

function Player:update(dt)
	-- Controls
	-- if Player.onfloor then
		if love.keyboard.isDown("d") then
			self.body:applyForce(self.force, 0)
		end
		if love.keyboard.isDown("a") then
			self.body:applyForce(-self.force, 0)
		end
	-- end
	local xvel, yvel = Player.body:getLinearVelocity()
	if xvel > Player.maxvel then
		Player.body:setLinearVelocity(Player.maxvel, yvel)
	elseif xvel < -Player.maxvel then
		Player.body:setLinearVelocity(-Player.maxvel, yvel)
	end
end

function Player:draw()
	-- Draws Player
	love.graphics.setColor(210, 15, 221)
	love.graphics.rectangle("fill", self.body:getX() - self.w / 2, self.body:getY() - self.h / 2, self.w, self.h)
end

function Player:setPosition(x, y)
	self.body:setPosition(x, y)
end

function Player:keypressed(key)
	if key == "space" and Player.onfloor then
		Player.body:applyLinearImpulse(0, -Player.jump)
	end
end

return Player
