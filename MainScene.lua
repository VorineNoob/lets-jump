-- 终于到游戏的场景了（搓手手）--

require("Scene")
require("Sprite")
require("Graph")
require("conf")
require("Text")
require("Barrier")
require("lib.Timer")
require("KeyboardEventManager")

LEFT_X = 50 																		-- 左线的X坐标
RIGHT_X = 500 																	-- 右线的X坐标
local JUMPING_STRENGTH = 7 * 60 								-- 跳跃的力度
local G = 9.1 																	-- 重力加速度
local MOVE_SPEED = 8 * 60 											-- 移动速度

MainScene = Scene()

MainScene.player = {}

function MainScene:init()
	print("MainScene:init() is running...")

	-- 玩家
	self.player = Sprite("assets/sprites/Player.png", LEFT_X, 0)
	self.player.width, self.player.height = 90, 90
	self.player.y = SCREEN_HEIGHT - 100 - self.player.height
	self.player.line = "left"
	self.player.oy, self.player.ox = 0, 0
	self.player.first_jump, self.player.second_jump = false, false
	-- 左边的线
	self.left_line = Graph("line", "line", {1, 1, 1, 1}, {LEFT_X, 0, LEFT_X, SCREEN_HEIGHT})
	-- 右边的线
	self.right_line = Graph("line", "line", {1, 1, 1, 1}, {RIGHT_X, 0, RIGHT_X, SCREEN_HEIGHT})

	self.left_barriers = {}
	self.right_barriers = {}

	-- 游戏是否已经启动
	self.is_game_started = false

	-- 游戏开始前的启动界面
	self.bs_title = Text("Lets Jump!", 0, SCREEN_HEIGHT / 2 - 150, 1080, "center", 150)
	self.bs_title:setColor(1, 1, 1, 1)
	self.bs_notice = Text("Press left arrow or right arrow to start game.", 0, SCREEN_HEIGHT / 2 + 20, 1080, "center", 21)
	self.bs_notice:setColor(1, 1, 1, 0.75)
	self.bs_notice.status = "down"

	-- 添加精灵
	self:add_text(self.bs_title)
	self:add_text(self.bs_notice)
	self:add_sprite(self.player)
	self:add_sprite(self.left_line)
	self:add_sprite(self.right_line)

	-- 添加键盘事件
	KeyboardEventManager:add_event(self.when_player_jump, {self, dt}, "up")
	KeyboardEventManager:add_event(self.when_left, {self, dt}, "left")
	KeyboardEventManager:add_event(self.when_right, {self, dt}, "right")

end

-- 当按下左键时
function MainScene:when_left(dt)
	if not self.is_game_started then
		self.is_game_started = true
		self.bs_title.removed = true
		self.bs_notice.removed = true
	end
	-- if self.player.line == "right" then
	self.player.ox = -MOVE_SPEED
	if self.player.line == "right" then
		-- 先处理 y 坐标
		if not self.player.first_jump then
			-- 一段跳
			self.player.first_jump = true
			self.player.oy = JUMPING_STRENGTH
		end
	end
	-- end
end

-- 当按下右键
function MainScene:when_right(dt)
	if not self.is_game_started then
		self.is_game_started = true
		self.bs_title.removed = true
		self.bs_notice.removed = true
	end

	-- if self.player.line == "left" then
	self.player.ox = MOVE_SPEED
	if self.player.line == "left" then
		-- 处理 y 坐标
		if not self.player.first_jump then
			-- 一段跳
			self.player.first_jump = true
			self.player.oy = JUMPING_STRENGTH
		end
	end
	-- end
end

-- 生成障碍
function MainScene:barrier_generate()
	local is_generate_left = math.random(1, 4) == 3
	local is_generate_right = math.random(1, 4) == 3

	if is_generate_left then
		local new_barrier = Barrier(0, LEFT_X, {1, 0, 0, 1}, "left")
		self:add_sprite(new_barrier)
		table.insert(self.left_barriers, new_barrier)
	end
	if is_generate_right then
		local new_barrier = Barrier(0, RIGHT_X, {1, 0, 0, 1}, "right")
		self:add_sprite(new_barrier)
		table.insert(self.right_barriers, new_barrier)
	end
end

-- 处理玩家的跳跃
function MainScene:when_player_jump(dt)

	-- 先处理 y 坐标
	if not self.player.first_jump then
		-- 一段跳
		self.player.first_jump = true
		self.player.oy = JUMPING_STRENGTH
	elseif self.player.line == "air" and (not self.player.second_jump) then
		-- 二段跳
		self.player.second_jump = true
		self.player.oy = JUMPING_STRENGTH
	end

	-- 再处理 x 坐标
	-- 如果现在是在左线上，那么就向右；在右线上，那么向左；在空中，那么不变
	if self.player.line == "left" then
		self.player.ox = MOVE_SPEED
	elseif self.player.line == "right" then
		self.player.ox = -MOVE_SPEED
	end

end

-- 更新玩家位置
function MainScene:player_position_update(dt)
	-- 如果在空气中或一段跳了
	-- if true --[[ self.player.line == "air" or self.player.first_jump ]] then
	-- 移动x
	self.player.x = self.player.x + self.player.ox * dt
	-- 更新oy
	self.player.oy = self.player.oy - G * 60 * dt
	-- 更新ox
	self.player.ox = self.player.ox * 0.99
	-- end
end

-- 更新 MainScene.player.line
function MainScene:update_player_line(dt)
	if self.player.x <= LEFT_X then
		self.player.line = "left"
		self.player.x = LEFT_X
		self.player.first_jump = false
		self.player.second_jump = false
		self.player.oy = MOVE_SPEED
	elseif self.player.x + self.player.width >= RIGHT_X then
		self.player.line = "right"
		self.player.x = RIGHT_X - self.player.width
		self.player.first_jump = false
		self.player.second_jump = false
		self.player.oy = MOVE_SPEED
	else
		self.player.line = "air"
	end
end

-- 游戏开始前提示的颜色更新
function MainScene:bs_notice_update(dt)

	if self.bs_notice.status == "down" then
		if self.bs_notice.A > 0.25 then
			self.bs_notice.A = self.bs_notice.A - 1 * dt
		else
			self.bs_notice.status = "up"
		end
	else
		if self.bs_notice.A < 0.75 then
			self.bs_notice.A = self.bs_notice.A + 1 * dt
		else
			self.bs_notice.status = "down"
		end
	end

end

-- 更新
function MainScene:update(dt)

	if not self.is_game_started then
		self:bs_notice_update(dt)
		return
	end

	-- print(self.player.oy * dt)

	-- 如果在线上，那么一段二段跳都重置
	if self.line == "left" or self.line == "right" then
		self.first_jump = false
		self.second_jump = false
	end

	-- 更新玩家坐标
	self:player_position_update(dt)
	-- 更新 MainScene.player.line
	self:update_player_line(dt)

	-- 障碍生成
	-- self:barrier_generate()
	for i, v in ipairs(self.left_barriers) do
		v:update(dt)
	end
	for i, v in ipairs(self.right_barriers) do
		v:update(dt)
	end
	Timer:interval_call(self.barrier_generate, {self}, 0.5, dt)
end

