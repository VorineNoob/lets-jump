-- conf.lua，关于游戏的设置 --
-- 720p，建议在设置里面调整
_G.SCREEN_WIDTH = 1080
_G.SCREEN_HEIGHT = 720

function love.conf(t)

	t.window.title = "NorthEast - LetsJump!"
	t.window.width = SCREEN_WIDTH
	t.window.height = SCREEN_HEIGHT

end

