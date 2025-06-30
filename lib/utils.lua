-- 一堆工具

-- 使用 font 字体 print 文字
function text_print(text, x, y, size)
	local font = love.graphics.newFont("assets/font.ttf", size)
	love.graphics.setFont(font)
	love.graphics.print(text, x, y)
end

-- 使用 font 字体 printf 文字
function text_printf(text, x, y, max_width, control, size)
	local font = love.graphics.newFont("assets/font.ttf", size)
	love.graphics.setFont(font)
	love.graphics.printf(text, x, y, max_width, control)
end

-- 获取变量的类型
function get_type(object)
	if type(object) == "table" then
		return object.type
	else
		return type(object)
	end
end

-- 根据参数表调用函数
function call(func, args)

	local unpack_func = table.unpack and table.unpack or unpack

	-- if type(func) == "function" and args then
	if type(func) == "function" then func(unpack_func(args)) end
	-- else
	-- 	error("args is empty!")
	-- end
end


