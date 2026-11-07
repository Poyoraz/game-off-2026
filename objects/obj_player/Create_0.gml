event_inherited()

max_coyote_time = 6
max_jump_buffer = 6

max_slide_effectiveness = 120
slide_effectiveness = max_slide_effectiveness

coyote_timer = max_coyote_time
jump_buffer = 0
jump_height = -35

_orig_grav = grav
_orig_drag = air_drag

dashing = false
max_dash_cooldown = 180
dash_cooldown = 0

controls_disabled = false

disable_controls = method(self, function() {
	controls_disabled = true
})

enable_controls = method(self, function() {
	controls_disabled = false
})

player_cast = []

_physics_item_on_collide = on_collide

on_collide = method(self, function(collidee, vertical) {
	if(dashing) interrupt_dash()
	
	_physics_item_on_collide(collidee, vertical)
})

interrupt_dash = method(self, function(collidee, vertical) {
	var _h_dir = horizontal_speed
	
	alarm[0] = -1
	stop_dash()
	
	vertical_speed = -10
	horizontal_speed *= -1
})

stop_dash = method(self, function() {
	enable_air_drag()
	enable_gravity()
	enable_controls()
	dashing = false
	
	vertical_speed /= 4
	horizontal_speed /= 4
})

warp = method(self, function(goal_x, goal_y, trace_backwards = false) {
	if(trace_backwards) return _warp_with_trace_backwards(goal_x, goal_y)
	
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
	
	player_cast = []
	
	
	var _max_iteration_count = point_distance(x, y, goal_x, goal_y) / STEP_SIZE
	
	for (var i = 0; i < _max_iteration_count; ++i) {
		if(place_meeting(
			_curr_x - _offset_x + _x_step, 
			_curr_y - _offset_y + _y_step, 
			obj_collidable
		)) break
		
		_curr_x += _x_step
		_curr_y += _y_step
		
		array_push(player_cast, [
			_curr_x - _offset_x, 
			_curr_y - _offset_y, 
		])
	}
	
	x = _curr_x - _offset_x
	y = _curr_y - _offset_y
	
	
})

_warp_with_trace_backwards = method(self, function(goal_x, goal_y) {
	var _dir = (point_direction(goal_x, goal_y, x, y) + 360) mod 360
	
	static STEP_SIZE = 5
	
	var _x_step = lengthdir_x(STEP_SIZE, _dir),
		_y_step = lengthdir_y(STEP_SIZE, _dir)
		
	var _offset_x,
		_offset_y
		
	if(_dir < 90 || _dir > 270) {
		_offset_x = bbox_left - x
	} else if(_dir == 90 || _dir == 270) {
		_offset_x = 0
	} else {
		_offset_x = bbox_right - x
	}
		
	if(_dir == 0 || _dir == 180) {
		_offset_y = 0
	} else if(_dir < 180) {
		_offset_y = bbox_bottom - y
	} else {
		_offset_y = bbox_top - y
	}
	
	var _curr_x = goal_x,
		_curr_y = goal_y
	
	player_cast = []
	
	var _max_iteration_count = point_distance(x, y, goal_x, goal_y) / STEP_SIZE
	
	for (var i = 0; i < _max_iteration_count; ++i) {
		if(!place_meeting(
			_curr_x - _offset_x, 
			_curr_y - _offset_y, 
			obj_collidable
		)) break
		
		_curr_x += _x_step
		_curr_y += _y_step
		
		array_push(player_cast, [
			_curr_x - _offset_x, 
			_curr_y - _offset_y, 
		])
	}
	
	x = _curr_x - _offset_x
	y = _curr_y - _offset_y
})