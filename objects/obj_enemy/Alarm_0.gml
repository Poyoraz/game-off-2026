///@desc Projector Loop

if(instance_exists(projector)) {
	__projector_blocked = instance_exists(
		collision_line(
			x,
			y,
			projector.x,
			projector.y,
			obj_collidable,
			false, 
			true
		)
	)
	
	alarm[0] = 5
} else {
	projector = noone
}