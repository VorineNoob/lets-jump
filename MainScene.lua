-- 终于到游戏的场景了（搓手手）--

require("Scene")
require("Sprite")
require("Graph")
require("conf")
require("Barrier")
require("lib.Timer")

LEFT_X = 50
RIGHT_X = 500

MainScene = Scene()

function MainScene:init()
	print("MainScene:init() is running...")

	-- 玩家
	self.player = Sprite("assets/sprites/Player.png", LEFT_X, 0)
	self.player.width, self.player.height = 90, 90
	self.player.y = SCREEN_HEIGHT - 100 - self.player.height
	-- 左边的线
	self.left_line = Graph("line", "line", {1, 1, 1, 1}, {LEFT_X, 0, LEFT_X, SCREEN_HEIGHT})
	-- 右边的线
	self.right_line = Graph("line", "line", {1, 1, 1, 1}, {RIGHT_X, 0, RIGHT_X, SCREEN_HEIGHT})

	self.left_barriers = {}
	self.right_barriers = {}

	-- 游戏是否已经启动
	self.is_game_started = false

	self:add_sprite(self.player)
	self:add_sprite(self.left_line)
	self:add_sprite(self.right_line)

end

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

function MainScene:update(dt)
	-- self:barrier_generate()
	for i, v in ipairs(self.left_barriers) do
		if v.removed then
			table.remove(self.left_barriers, i)
		else
			v:update(dt)
		end
	end
	for i, v in ipairs(self.right_barriers) do
		if v.removed then
			table.remove(self.right_barriers, i)
		else
			v:update(dt)
		end
	end
	Timer:interval_call(self.barrier_generate, {self}, 1, dt)
end

