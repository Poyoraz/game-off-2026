if(instance_exists(grappled)) {
	if(grappled.weight == infinity) {
		obj_player.warp(x, y, true)
	} else {
		grappled.on_grapple_pull(80, point_direction(x, y, obj_player.x, obj_player.y))
	}
}

instance_destroy()