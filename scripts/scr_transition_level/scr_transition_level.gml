function scr_transition_level(target_room){
	with(obj_physics_item) {
		disable_physics()
	}
	
	instance_destroy(obj_bullet)
	
	obj_player.start_transition = 100
	
	run_headless_animation(
		new LinearCombinedAnimation([
			new ParallelCombinedAnimation([
				new ConditionAnimation(function() {
					return obj_player.screen_transition >= 100
				})
			]),
			new RunFunctionAnimation(method({ target_room }, function() {
				room_goto(target_room)
			}))
		]),
		0,
		0,
		-1
	)
}