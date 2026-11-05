instance_destroy()

if(instance_exists(grappled)) {
	if(grappled.weight == infinity) {
		var pull_momentum = 80,
			dir = point_direction(obj_player.x, obj_player.y, x, y)
	
		var _h_pull = lengthdir_x(pull_momentum, dir),
			_v_pull = lengthdir_y(pull_momentum, dir)
		
		obj_player.transmit_momentum(_h_pull)
		obj_player.transmit_momentum(_v_pull, true)
	} else {
		var pull_momentum = 80,
			dir = point_direction(x, y, obj_player.x, obj_player.y)
	
		var _h_pull = grappled.lock_vertical 
				? sign(dcos(dir)) * pull_momentum 
				: lengthdir_x(pull_momentum, dir),
			_v_pull = grappled.lock_horizontal 
				? -sign(dsin(dir)) * pull_momentum  
				: lengthdir_y(pull_momentum, dir)
		
		grappled.transmit_momentum(_h_pull)
		grappled.transmit_momentum(_v_pull, true)
	}
}