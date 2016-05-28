local World = {}

function World:create()
	local world = {}

	world.objects = {}

	function world:add(obj)
		table.insert(self.objects, obj)
	end

	function world:update(dt)
		for i = 0, #self.objects do
			local obj = self.objects[i]
			if obj then
				obj:update(dt)
			end
		end
	end

	return world
end

return World
