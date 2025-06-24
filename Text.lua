-- Text 类，用于存储某个文字 --

require("GameObject")
require("lib.utils")

function Text(text, x, y, max_width, control, size)

	local object = GameObject("Text")

	object.text = text
	object.x = x
	object.y = y
	object.max_width = max_width
	object.control = control
	object.size = size

	object.R = 1
	object.G = 1
	object.B = 1
	object.A = 1

	function object:setColor(r, g, b, a)
		self.R = r
		self.G = g
		self.B = b
		self.A = a
	end

	function object:draw()
		love.graphics.setColor(object.R, object.G, object.B, object.A)
		text_printf(self.text, self.x, self.y, self.max_width, self.control, self.size)
	end

	return object

end
