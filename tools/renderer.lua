local Renderer = {}
local num_of_layers = 5

function Renderer:create(filterDown, filterUp, tilewidth, tileheight)
	love.graphics.setDefaultFilter(filterDown, filterUp)

	local renderer = {}
	-- The distance from the player to render stuff
	renderer.Xdistance = Width / 2 + tilewidth / 2
	renderer.Ydistance = Height / 2 + tileheight / 2

	-- Table with all the layers with all the objects in those layers
	renderer.drawer = {}
	for i = 0, num_of_layers do
		renderer.drawer[i] = {}
	end

	-- Add some object to the layer
	function renderer:add(obj, layer)
		local l = layer or 0
		table.insert(self.drawer[l], obj)
	end

	-- Draw all the objects in all the layers
	function renderer:draw(fps)
		-- Starts screen scalling
		Push:apply("start")

		-- Set camera
		camera:set()
		love.graphics.setColor(255, 255, 255)
		for layer = 0, #self.drawer do
			for draw = 0, #self.drawer[layer] do
				local obj = self.drawer[layer][draw]
				if obj then
					obj:draw()
				end
			end
		end
		-- Unset camera
		camera:unset()

		-- Ends screen scalling
		Push:apply("end")

		if fps == "fps" then love.graphics.print(love.timer.getFPS()) end
	end

	function renderer:setRenderDistance(dis)
		self.distance = dis
	end

	function renderer:clean()

	end

	return renderer
end

return Renderer
