function run_headless_animation(animation, _x, _y, _depth){
	var handler = instance_create_depth(
		_x,
		_y,
		_depth,
		obj_animation_runner
	)

	handler.set_animations([
		animation,
		new RunFunctionAnimation(function(item) {
			item.alarm[0] = 1
		})
	])
}