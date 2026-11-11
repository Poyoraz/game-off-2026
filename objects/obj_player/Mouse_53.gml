var _dir = point_direction(x, y, mouse_x, mouse_y)

if(instance_exists(bashing)) {
	bash(_dir)

	return;
}

if(!instance_exists(obj_hook)) {
	var hook = instance_create_depth(x, y, depth - 1, obj_hook, {
		speed: 120,
		direction: _dir,
		image_angle: _dir
	})
}