if(!__initialized) exit

obj_player.disable_hook = true
obj_player.alarm[2] = 1

if(instance_exists(grappled)) {
	if(grappled.weight == infinity) {
		obj_player.warp(x, y, true)
	} else {
		grappled.on_grapple_pull(80, point_direction(x, y, obj_player.x, obj_player.y))
	}
	instance_destroy()
} else {
	fail_hook()
}