-- Barrier 障碍物类 --

require("Graph")
require("conf")

local MOVE_SPEED = 420
local SIDE_LENGTH = 80

function Barrier(x, y, rgba, side)

	local object = Graph("barrier", "", rgba)

	object.y = 0
	object.x1, object.y1, object.x2, object.y2, object.x3, object.y3 = 0, 0, 0, 0, 0, 0
	object.side = side

	if object.side == "left" then object.x = LEFT_X end
	if object.side == "right" then object.x = RIGHT_X end

	object.removed = false

	function object:update(dt)
		-- 移动
		-- self.y = self.y + MOVE_SPEED * dt
		self.y = self.y + MainScene.player.oy * dt

		-- 计算是否越界
		if self.y - SIDE_LENGTH / 2 >= SCREEN_HEIGHT then
			self.removed = true
		else
			self.removed = false
		end

		self.x1 = self.x
		self.y1 = self.y - SIDE_LENGTH / 2

		self.x2 = self.x
		self.y2 = self.y + SIDE_LENGTH / 2

		-- 用勾股算出等边三角形的高 = (√3a) / 2
		local triangle_height = (math.sqrt(3) * SIDE_LENGTH) / 2

		-- 再根据障碍类型推算x即可
		if self.side == "left" then
			self.x3 = self.x + triangle_height
		else
			self.x3 = self.x - triangle_height
		end
		self.y3 = self.y
	end

	function object:draw()
		call(love.graphics.setColor, self.rgba)
		love.graphics.polygon("line", self.x1, self.y1, self.x3, self.y3, self.x2, self.y2)
		-- 绘制碰撞框以调试
		if self.side == "left" then
			love.graphics.rectangle("line", self.x1, self.y1, self.x3 - self.x1, self.y2 - self.y1)
		else
			love.graphics.rectangle("line", self.x3, self.y2, self.x1 - self.x3, self.y1 - self.y2)
		end
	end

	return object

end

