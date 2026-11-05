var _dir = point_direction(x, y, mouse_x, mouse_y)

var hook = instance_create_depth(x, y, depth - 1, obj_hook, {
	speed: 80,
	direction: _dir,
	image_angle: _dir
})