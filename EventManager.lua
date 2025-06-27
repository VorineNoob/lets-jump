-- EventManager 事件管理类，用于管理初始化，每帧等事件，单例 --

require("lib.utils")

EventManager = {}

EventManager.game_objects = {}                                      -- 需要接受事件处理的游戏对象，必须有 init, update 和 draw 函数

-- 运行初始化函数
function EventManager:init()
	-- print("EventManager:init() was run.")
	for i, v in ipairs(self.game_objects) do
		v:init()
	end
end

-- 输出表里面的对象
function EventManager:print_objects()
	print("-- EventManager.game_objects --")
	local tmp = {}
	for i, v in ipairs(self.game_objects) do
		tmp[i] = get_type(v)
	end
	
	print(table.concat(tmp, ", "))
end

-- 运行更新函数
function EventManager:update(dt)
	-- print("EventManager:update(dt) was run.")
	for i, v in ipairs(self.game_objects) do
		if v.update then
			-- print(string.format("EventManager:update(): calling %s:update().", get_type(v)))
			v:update(dt)
		end
	end
end

-- 运行更新函数
function EventManager:draw()
	-- print("EventManager:draw() was run.")
	for i, v in ipairs(self.game_objects) do
		v:draw()
	end
end

-- 添加对象
function EventManager:add_handle_object(object)
	-- print(string.format("EventManager:add_handle_object(%s) was run.", get_type(object)))
	if type(object) == "table" then
		table.insert(self.game_objects, object)
		return true
	else
		print("EventManager:add_handle_object(): arg isnt table!")
		return false
		-- error("EventManager:add_handle_object(): arg isnt GameObject!")
	end
end

-- -- 添加初始化函数
-- function EventManager:add_init(func)
	-- 	print("EventManager:add_init() was run.")
	-- 	if get_type(func) == "function" then
	-- 		self.init_functions:insert(func);
	-- 		table.insert(self.init_functions)
	-- 	else
	-- 		error("EventManager:add_init(): arg isnt function!")
	-- 	end
	-- end

	-- -- 进行事件处理
	-- function EventManager:update()
		-- 	print("EventManager:update() was run.")
		-- 	for i, v in ipairs(self.update_functions) do
		-- 		v()
		-- 	end
		-- end

		-- -- 添加事件处理函数
		-- function EventManager:add_update(func)
			-- 	print("EventManager:add_update() was run.")
			-- 	if get_type(func) == "function" then
			-- 		-- self.update_functions:insert(func);
			-- 		table.insert(self.update_functions, func)
			-- 	else
			-- 		error("EventManager:add_update(): arg isnt function!")
			-- 	end
			-- end

			-- -- 进行绘图
			-- function EventManager:draw()
				-- 	print("EventManager:draw() was run.")
				-- 	for i, v in ipairs(self.draw_functions) do
				-- 		v()
				-- 	end
				-- end

				-- -- 添加绘图函数
				-- function EventManager:add_draw(func)
					-- 	print("EventManager:add_draw() was run.")
					-- 	if get_type(func) == "function" then
					-- 		self.draw_functions:insert(func);
					-- 		table.insert(self.draw_functions, func)
					-- 	else
					-- 		error("EventManager:add_draw(): arg isnt function!")
					-- 	end
					-- end
