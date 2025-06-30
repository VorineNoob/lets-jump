_G.love = require("love")
require("lib.utils")
require("EventManager")
require("GameObject")
require("GameStatusManager")
require("MainScene")
require("LogoScene")
require("MemoryManager")
require("Scene")
require("SceneManager")
require("Text")

-- 关于 love 运行时的参数处理
local args = {}

-- print("-------")
for k, v in pairs(love.arg.parseGameArguments(arg)) do
	args[v] = true
	-- print(v)
end
-- print("-------")

if args["--fastdebug"] then
	SceneManager:set_current_scene(MainScene)
else
	SceneManager:set_current_scene(LogoScene)
end

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

