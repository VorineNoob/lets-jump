-- 哇，是 MemoryManager 类，跟别的类不一样欸（因为是单例模式） --

local free_memory_functions = {} 							-- 释放内存时需要运行的函数

MemoryManager = {} 											-- 单例模式 - 对象

-- 往 free_memory_functions 里面添加函数
function MemoryManager:add_free_function(func)
	if type(func) ~= "function" then
		error("MemoryManager:add_free_function(): arg isnt function!")
		return false
	end

	free_memory_functions:insert(func)

	return true
end

-- 释放内存
function MemoryManager:free_memory()
	for i, v in ipairs(free_memory_functions) do
		v()
	end
end
