-- Garph 图形类，用于绘制图形 --

require("GameObject")
require("lib.utils")

function Graph(type, mode, rgba, draw_args)

	local object = GameObject("Graph")

	object.graph_type = type
	object.mode = mode
	object.rgba = rgba
	object.draw_args = draw_args

	function object:draw()

		-- print("Graph:draw(): Calling setColor..")
		call(love.graphics.setColor, self.rgba)

		-- print("Graph:draw(): drawing...")
		if self.graph_type == "rect" then
			call(love.graphics.rectangle, self.mode .. self.draw_args)
		elseif self.graph_type == "circle" then
			call(love.graphics.circle, self.mode .. self.draw_args)
		elseif self.graph_type == "line" then
			call(love.graphics.line, self.draw_args)
		elseif self.graph_type == "arc" then
			call(love.grahpics.arc, self.mode .. self.draw_args)
		elseif self.graph_type == "triangle" then
			call(love.graphics.triangle, self.mode .. self.draw_args)
		end
	end

	return object

end

