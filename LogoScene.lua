-- LogoScene 类，即进入游戏时那个场景类 --

require("Scene")
require("conf")
require("Text")
require("GameNameScene")

-- 单例模式的单个对象
LogoScene = Scene()

-- 中间几个大字，Text 对象
LogoScene.logo_text = {}

function LogoScene:init()
	-- 调试信息而已，其他的 print 都是调试信息，别在意
	print("LogoScene:init() was run.")

	-- 初始化中间那个大字
	self.logo_text = Text("NorthEast", 0, SCREEN_HEIGHT / 2 - 120, 1080, "center", 150)
	self.logo_text:setColor(1, 1, 1, 0)

	-- 这里是大字淡入淡出效果
	local tmp = 0
	local status = "up"
	local SPEED = 0.5
	function self.logo_text:update(dt)

		print(string.format("GameNameScene.logo_text:update(): status=%s", status))

		-- 此处，淡入
		if status == "up" then
			if self.A < 1 then
				self.A = self.A + SPEED * dt
			else
				status = "down"
			end

		-- 此处，淡出
		elseif status == "down" then
			-- 停留一会
			if tmp < 1 then tmp = tmp + 1 * dt end
			if tmp >= 1 then
				if self.A > 0 then
					self.A = self.A - SPEED * dt
				else
					status = "stop"
				end
			end

		-- 停下了
		else
			-- 切换到下一个场景干嘛，愣着啊
			LogoScene.is_next_scene = true
		end
	end

	-- 下一个场景直接回去2333
	self.next_scene = GameNameScene
	-- 你要记得这是初始化函数哦不要被上面的那个 update() 给迷晕了
	self.is_next_scene = false

	-- 写完了大字当然要添加到对象里面
	self:add_text(self.logo_text)
end

-- 更新
function LogoScene:update(dt)
	print("LogoScene:update(): running..")
	if self.logo_text.update then self.logo_text:update(dt) end
end


	-- function LogoScene.logo_text:update(dt)
		-- 	print(dt)
		-- end



