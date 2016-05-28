local Renderer = {}
local num_of_layers = 5

function Renderer:create()
	local renderer = {}

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
		Push:apply("start")
		love.graphics.setColor(255, 255, 255)
		for layer = 0, #self.drawer do
			for draw = 0, #self.drawer[layer] do
				local obj = self.drawer[layer][draw]
				if obj then
					obj:draw()
				end
			end
		end
		Push:apply("end")

		if fps == "fps" then love.graphics.print(love.timer.getFPS()) end
	end

	function renderer:clean()

	end

	return renderer
end

return Renderer
