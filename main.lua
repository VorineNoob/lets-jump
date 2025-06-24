_G.love = require("love")
require("lib.utils")
require("EventManager")
require("GameObject")
require("GameStatusManager")
require("LogoScene")
require("MemoryManager")
require("Scene")
require("SceneManager")
require("Text")

function love.load()
	EventManager:print_objects()
	EventManager:init()
end

function love.update(dt)
	EventManager:update(dt)
end

function love.draw()
	EventManager:draw()
end
