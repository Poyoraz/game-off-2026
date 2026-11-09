if(instance_exists(grappled)) {
	var _displacement_x = grappled.x - grappled.xprevious,
		_displacement_y = grappled.y - grappled.yprevious
		
	x += _displacement_x
	y += _displacement_y
}


with(obj_player) {
	var line_collides = collision_line(
		x,
		y,
		other.x,
		other.y,
		obj_collidable,
		false,
		true
	)
		
	if(instance_exists(line_collides)) {
		instance_destroy(other)
	}
}