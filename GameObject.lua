-- GameObject 类，游戏中的所有对象都需要继承自它 --

require("EventManager")

function GameObject(type)
	print(string.format("GameObject(%s) was run.", type))

	local object = {}

	object.type = type

	function object:init() end
	function object:update() end
	function object:draw() end

	return object

end
