-- 终于到游戏的场景了（搓手手）--

require("Scene")
require("Sprite")

MainScene = Scene()

function MainScene:init()
	print("MainScene:init() is running...")

	self.player = Sprite("assets/sprites/Player.png", 200, 200)
	
end

function MainScene:draw()
	print("MainScene:draw() is running...")
	self.player:draw()
end

