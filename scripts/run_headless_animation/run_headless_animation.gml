function run_headless_animation(animation, _x, _y, _depth, use_ui_layer = false){
	var handler = instance_create_depth(
		_x,
		_y,
		_depth,
		obj_animation_runner,
		{
			gui_item: use_ui_layer
		}
	)

	handler.set_animations([
		animation,
		new RunFunctionAnimation(function(item) {
			item.alarm[0] = 1
		})
	])
}