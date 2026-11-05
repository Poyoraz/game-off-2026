var _has_valid_grapple = false

if(instance_exists(obj_hook)) {
	if(instance_exists(obj_hook.grappled)) _has_valid_grapple = true
}

var _dir = _has_valid_grapple
	? point_direction(x, y, obj_hook.x, obj_hook.y)
	: (floor((point_direction(x, y, mouse_x, mouse_y) + 22.5) / (360 / 8)) mod 8) * 45

if(_has_valid_grapple) instance_destroy(obj_hook)

air_drag = 0

alarm[0] = 10

horizontal_speed = lengthdir_x(35, _dir)
vertical_speed = lengthdir_y(35, _dir)