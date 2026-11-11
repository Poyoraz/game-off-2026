function scr_warp_object_with_collision(goal_x, goal_y, trace_backwards = false){
	if(trace_backwards) return _scr_warp_with_backwards_trace(goal_x, goal_y)
	
	var _dir = (point_direction(x, y, goal_x, goal_y) + 360) mod 360
	
	static STEP_SIZE = 5
	
	var _x_step = lengthdir_x(STEP_SIZE, _dir),
		_y_step = lengthdir_y(STEP_SIZE, _dir)
		
	var _offset_x,
		_offset_y
		
	if(_dir < 90 || _dir > 270) {
		_offset_x = bbox_right - x
	} else if(_dir == 90 || _dir == 270) {
		_offset_x = 0
	} else {
		_offset_x = bbox_left - x
	}
		
	if(_dir == 0 || _dir == 180) {
		_offset_y = 0
	} else if(_dir < 180) {
		_offset_y = bbox_bottom - y
	} else {
		_offset_y = bbox_top - y
	}
	
	var _curr_x = x + _offset_x,
		_curr_y = y + _offset_y
	
	var _max_iteration_count = point_distance(x, y, goal_x, goal_y) / STEP_SIZE
	
	for (var i = 0; i < _max_iteration_count; ++i) {
		if(place_meeting(
			_curr_x - _offset_x + _x_step, 
			_curr_y - _offset_y + _y_step, 
			obj_collidable
		)) break
		
		_curr_x += _x_step
		_curr_y += _y_step
	}
	
	x = _curr_x - _offset_x
	y = _curr_y - _offset_y
}

function _scr_warp_with_backwards_trace(goal_x, goal_y) {
	var _dir = (point_direction(goal_x, goal_y, x, y) + 360) mod 360
	
	static STEP_SIZE = 5
	
	var _x_step = lengthdir_x(STEP_SIZE, _dir),
		_y_step = lengthdir_y(STEP_SIZE, _dir)
		
	var _offset_x,
		_offset_y
		
	if(_dir < 90 || _dir > 270) {
		_offset_x = max(bbox_left - x, -abs(x - goal_x))
	} else if(_dir == 90 || _dir == 270) {
		_offset_x = 0 
	} else {
		_offset_x = min(bbox_right - x, abs(x - goal_x))
	}
		
	if(_dir == 0 || _dir == 180) {
		_offset_y = 0
	} else if(_dir < 180) {
		_offset_y = min(bbox_bottom - y, abs(y - goal_y))
	} else {
		_offset_y = max(bbox_top - y, -abs(y - goal_y))
	}
	
	var _curr_x = goal_x,
		_curr_y = goal_y
	
	var _max_iteration_count = point_distance(x, y, goal_x, goal_y) / STEP_SIZE
	
	for (var i = 0; i < _max_iteration_count; ++i) {
		if(!place_meeting(
			_curr_x - _offset_x, 
			_curr_y - _offset_y, 
			obj_collidable
		)) break
		
		_curr_x += _x_step
		_curr_y += _y_step
	}
	
	x = _curr_x - _offset_x
	y = _curr_y - _offset_y
}