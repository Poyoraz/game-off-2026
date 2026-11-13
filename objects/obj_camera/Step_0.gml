var goal_width = round(_base_size * zoom_level)

var _view_x = camera_get_view_width(camera) 

if(
	_view_x != goal_width
) {
	var goal_height = round(goal_width * (1/aspect_ratio)),
		_view_y = camera_get_view_height(camera)
		
	var _curr_x = scr_ease_value(_view_x, goal_width, 5, true, 5)
	
	camera_set_view_size(
		camera,
		_curr_x,
		_curr_x * (1/aspect_ratio)
	)
}