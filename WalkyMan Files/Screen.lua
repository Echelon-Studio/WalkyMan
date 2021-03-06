local Default_Indexes = {
	['Text'] = 5,
	['Background'] = 1
}

return ({
	new = function()
		local handler = { }
		handler.height = love.graphics.getHeight()
		handler.width = love.graphics.getWidth()
		handler.draw_stack = { }
		handler.index_stack = { }
		
		function handler:add_Object(object, index)
			if not object then return end
			local index = index~=nil and index or 2
			index = type(index)=='string' and Default_Indexes[index] or tonumber(index)
			if self.draw_stack[index]==nil then
				self.draw_stack[index] = { }
			end
			self.draw_stack[index][object] = object
			self.index_stack[object] = index
		end
	
		function handler:remove_Object(object)
			if self.index_stack[object] then
				self.draw_stack[self.index_stack[object]][object] = nil
				self.index_stack[object] = nil
			end
		end
		
		function handler:update_Object(object, index)
			self:remove_Object(object)
			self:add_Object(object, index)
		end

		return handler
	end})
	