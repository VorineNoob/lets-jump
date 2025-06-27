-- Sprite 精灵类，用于存储图片对象 --

require("GameObject")

function Sprite(path, x, y)

	local object = GameObject("Sprite")

	object.path = path 																		-- 图片路径
	object.x = x 																					-- 图片左上角的x坐标
	object.y = y 																					-- 图片右上角的y坐标

	object.image = love.graphics.newImage(object.path) 		-- 图像的image对象

	function object:init() end
	function object:update(dt) end
	function object:draw()
		-- print("Sprite:draw() is running!")

		love.graphics.setColor(1, 1, 1, 1) 									-- 注意这里，当时就是因为这里我调试了好久(在 GameNameScene 那里 Alpha 设置成 0 了)

		-- if object.image then print("A sprite is not nil!") end
		love.graphics.draw(self.image, self.x, self.y)
	end

	function object:move(ox, oy)
		-- print("A sprite is moving!")
		self.x = self.x + ox
		self.y = self.y + oy
	end

	return object

end


