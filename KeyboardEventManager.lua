-- KeyboardEventManager 键盘事件管理类，用于在每次触发键盘的时候检查是否需要执行函数 --

require("lib.utils")

KeyboardEventManager = {}

-- 需要检查的键盘事件，其中有一个执行的函数(func)，函数的参数列表(args)，以及一个调用函数时需要的按键(scancode)
KeyboardEventManager.check_events = {}

function love.keypressed(key, scancode, isrepeat)
	for i, v in ipairs(KeyboardEventManager.check_events) do
		if v.scancode == scancode then
			call(v.func, v.args)
		end
	end
end

function KeyboardEventManager:add_event(func, args, scancode)
	table.insert(self.check_events, {func = func, args = args, scancode = scancode})
end



