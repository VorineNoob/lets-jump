-- SceneManager 场景管理类，用于管理场景，单例 --

require("Scene")
require("LogoScene")
require("EventManager")
require("MainScene")
require("GameNameScene")

SceneManager = GameObject("SceneManager")

SceneManager.current_scene = nil

EventManager:add_handle_object(SceneManager)

function SceneManager:init()
	-- self.current_scene = MainScene
	self.current_scene:init()
end

function SceneManager:set_current_scene(scene)
	if get_type(scene) == "Scene" then
		self.current_scene = scene
		print("set current_scene")
	else
		error("SceneManager:set_current_scene(): arg isnt Scene!")
	end
end

function SceneManager:update(dt)
	-- print(string.format("SceneManager:update(dt): calling %s:update(dt)", get_type(self.current_scene)))

	self.current_scene:update(dt)
	if self.current_scene.is_next_scene then
		print("SceneManager:update(): Scene changed!!!")
		self.current_scene = self.current_scene.next_scene
		self.current_scene:init()
	end
end

function SceneManager:draw()
	self.current_scene:draw()
end

