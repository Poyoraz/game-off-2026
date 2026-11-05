var _dist = point_distance(x, y, obj_player.x, obj_player.y)

if(_dist > 800) {
	instance_destroy()
} else {
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
}