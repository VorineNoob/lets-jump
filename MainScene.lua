-- 终于到游戏的场景了（搓手手）--

require("Scene")
require("Sprite")
require("Graph")
require("conf")

local LEFT_X = 50
local RIGHT_Y = 500

MainScene = Scene()

function MainScene:init()
	print("MainScene:init() is running...")

	self.player = Sprite("assets/sprites/Player.png", LEFT_X, 0)
	self.player.width, self.player.height = 90, 90
	self.player.y = SCREEN_HEIGHT - 100 - self.player.height
	self.left_line = Graph("line", "line", {1, 1, 1, 1}, {LEFT_X, 0, LEFT_X, SCREEN_HEIGHT})
	self.right_line = Graph("line", "line", {1, 1, 1, 1}, {RIGHT_Y, 0, RIGHT_Y, SCREEN_HEIGHT})

	self:add_sprite(self.player)
	self:add_sprite(self.left_line)
	self:add_sprite(self.right_line)

end

function MainScene:update(dt)
end

