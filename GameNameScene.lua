-- GameNameScene 游戏名称场景类，接续在 LogoScene 后，显示游戏名称，单例 --

require("Scene")
require("conf")
require("Text")
require("MainScene")

-- 单例模式的单个对象
GameNameScene = Scene()

-- 中间几个大字，Text 对象，复制 LogoScene 的代码来的，懒得改变量名了凑合用罢
GameNameScene.logo_text = {}

function GameNameScene:init()
	-- 调试信息而已，其他的 print 都是调试信息，别在意
	print("GameNameScene:init() was run.")

	-- 初始化中间那个大字
	self.logo_text = Text("LetsJump", 0, SCREEN_HEIGHT / 2 - 120, 1080, "center", 150)
	self.logo_text:setColor(0 / 255, 144 / 255, 255 / 255, 0)

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
			if tmp < 1 then tmp = tmp + dt
			else
				if self.A > 0 then
					self.A = self.A - SPEED * dt
				else
					status = "stop"
				end
			end

		-- 停下了
		else
			-- 切换到下一个场景干嘛，愣着啊
			GameNameScene.is_next_scene = true
		end
	end

	-- 下一个场景去到游戏主界面
	self.next_scene = MainScene
	-- 你要记得这是初始化函数哦不要被上面的那个 update() 给迷晕了
	self.is_next_scene = false

	-- 写完了大字当然要添加到对象里面
	self:add_text(self.logo_text)
end

-- 更新
function GameNameScene:update(dt)
	print("GameNameScene:update(): running..")
	if self.logo_text.update then self.logo_text:update(dt) end
end


	-- function GameNameScene.logo_text:update(dt)
		-- 	print(dt)
		-- end




