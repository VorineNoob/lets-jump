-- GameStatusManager 游戏状态管理类，用于管理游戏的状态，单例模式 --

require("GameObject")
require("EventManager")

GameStatusManager = GameObject("GameStatusManager")

EventManager:add_handle_object(GameStatusManager)

function GameStatusManager:exit_handle()
	if love.keyboard.isDown("escape") then
		love.window.close()
		MemoryManager:free_memory()
		os.exit(0)
	end
end

function GameStatusManager:update()
	self:exit_handle()
end

