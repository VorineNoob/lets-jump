-- Timer，当然还是一堆库，不过是定时器 --

require("lib.utils")

Timer = {}

Timer.intervals = {}

-- 定时调用
function Timer:interval_call(func, args, delay_second, dt)

	local func_index = tostring(func)

	-- 当定时回调方案不存在时初始化
	if not self.intervals[func_index] then
		self.intervals[func_index] = {}
		self.intervals[func_index].time = 0
		self.intervals[func_index].status = true
	end

	-- 如果没有开启那么不执行
	if not self.intervals[func_index].status then
		self.intervals[func_index].time = 0
		return
	end

	-- 核心：每次加上 dt，1s 就会 + 1
	self.intervals[func_index].time = self.intervals[func_index].time + dt

	-- 当到达指定时间时执行
	if self.intervals[func_index].time >= delay_second then
		call(func, args)
		self.intervals[func_index].time = 0
	end
end

-- 启用方案
function Timer:enable(func)
	local func_index = tostring(func)
	if not self.intervals[func_index] then
		error("You wont want to enable a non-existent interval callback function")
	end
	self.intervals[func_index].status = true
end

-- 禁用方案
function Timer:disable(func)
	local func_index = tostring(func)
	if not self.intervals[func_index] then
		error("You wont want to disable a non-existent interval callback function")
	end
	self.intervals[func_index].status = false
end


