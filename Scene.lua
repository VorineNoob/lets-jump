-- 场景类 --

require("lib.utils")
require("GameObject")

function Scene()
	print("Scene() was run.")
	-- 继承自 GameObject --
	local object = GameObject("Scene")

	object.sprites = {}													-- 场景中的所有精灵
	object.texts = {} 													-- 场景中的所有文字
	object.background = nil 										-- 场景的背景

	object.update_functions = {} 								-- 每帧中需要处理的事件

	object.is_next_scene = false 								-- 是否去到下一个场景
	object.next_scene = nil											-- 下一个场景

	-- 初始化场景
	function object:init() end

	-- 绘制场景
	function object:draw()
		-- print("Scene:draw() was run.")
		for i, v in ipairs(self.sprites) do
			if not v.removed then
				v:draw()
			end
			-- if v.removed then
			-- 	table.remove(self.sprites, i)
			-- 	v = nil
			-- else
			-- 	v:draw()
			-- end
		end
		for i, v in ipairs(self.texts) do
			if not v.removed then
				v:draw()
			end
		end

		if self.background then self.background:draw() end
	end

	-- 往场景中添加精灵
	function object:add_sprite(sprite)
		print("Scene:add_sprite() was run.")
		if get_type(sprite) == "Sprite" or get_type(sprite) == "Graph" then
			table.insert(self.sprites, sprite)
			return true
		else
			error(string.format("object:add_sprite(): arg isnt a Sprite!(%s)", get_type(sprite)))
			return false
		end
	end

	-- 往设置场景的背景
	function object:set_background(picture)
		print("Scene:set_background() was run.")
		if get_type(picture) == "Sprite" then
			self.background = picture
			return true
		else
			error("object:set_background(): arg isnt a Sprite!")
			return false
		end
	end

	-- 往场景中添加文字
	function object:add_text(text)
		print(string.format("Scene:add_text(%s(%s)) was run.", get_type(text), type(text)))
		if get_type(text) == "Text" then
			table.insert(self.texts, text)
			return true
		else
			print("object:add_text(): arg isnt a Text!")
			return false
		end
	end

	function object:add_update_function(func)
		print("Scene:add_update_function() was run.")
		if get_type(func) == "function" then
			table.insert(self.update_functions, func)
			return true
		else
			error("object:add_update_function(): arg isnt a function!")
			return false
		end
	end

	-- 进行每帧的事件判断
	function object:update(dt)
		-- print("Scene:update() was run.")
		for i, v in ipairs(self.update_functions) do
			v(dt)
		end
	end

	return object

end

