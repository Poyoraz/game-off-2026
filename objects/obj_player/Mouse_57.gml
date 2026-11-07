var _has_valid_grapple = false

if(instance_exists(obj_hook)) {
	if(instance_exists(obj_hook.grappled)) _has_valid_grapple = true
}

var _dir = _has_valid_grapple
	? point_direction(x, y, obj_hook.x, obj_hook.y)
	: (floor((point_direction(x, y, mouse_x, mouse_y) + 22.5) / (360 / 8)) mod 8) * 45

if(_has_valid_grapple) {
x = obj_hook.x
y = obj_hook.y
	
instance_destroy(obj_hook)
}

//air_drag = 0
coyote_timer = 0

//alarm[0] = 10

var _speed = _has_valid_grapple ? 60 : 35

horizontal_speed = lengthdir_x(20, _dir)
vertical_speed = lengthdir_y(10, _dir)