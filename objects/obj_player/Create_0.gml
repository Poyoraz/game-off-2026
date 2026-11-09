event_inherited()

max_coyote_time = 6
max_jump_buffer = 6

invincibility = 0

max_slide_effectiveness = 120
slide_effectiveness = max_slide_effectiveness

coyote_timer = max_coyote_time
jump_buffer = 0
jump_height = -35

_orig_grav = grav
_orig_drag = air_drag

dashing = false
ground_pounding = false
max_dash_cooldown = 180
dash_cooldown = 0

controls_disabled = false

disable_controls = method(self, function() {
	controls_disabled = true
})

enable_controls = method(self, function() {
	controls_disabled = false
})

damage = method(self, function() {
	if(invincibility > 0) return;
	
	global.persistent_player_data.hp--
	invincibility = invincibility_duration
})

player_cast = []

_physics_item_on_collide = on_collide

on_collide = method(self, function(collidee, vertical) {
	if(dashing) interrupt_dash(collidee)
	
	_physics_item_on_collide(collidee, vertical)
})

interrupt_dash = method(self, function(collidee) {
	var _h_dir = horizontal_speed
	
	if(ground_pounding) create_shockwave(collidee)
	
	alarm[0] = -1
	stop_dash()
	
	vertical_speed = -10
	horizontal_speed *= -1
})

create_shockwave = method(self, function(collidee) {
	var colliding_list = ds_list_create()
	
	var _precollide_count = collision_line_list(
		bbox_left, 
		collidee.bbox_top + 1, 
		bbox_right, 
		collidee.bbox_top + 1,
		obj_collidable, false, true,
		colliding_list,
		false
	)
	
	var _precollide_list = ds_list_to_array(colliding_list)
	ds_list_destroy(colliding_list)
	
	for (var i = 0; i < _precollide_count; ++i) {
	    var _item = _precollide_list[i]
		
		_item.transmit_momentum(120, true, TransmitMomentumType.SHOCKWAVE)
	}
	
	array_push(_precollide_list, id)
	
	for (var i = 0; i < 2; ++i) {
	    var _dir =  i * 180
		
		instance_create_depth(
			x,
			collidee.bbox_top,
			depth - 1,
			obj_shockwave,
			{
				direction: _dir,
				initial_items: _precollide_list
			}
		)
	}
})

bashing = noone
set_bash = method(self, function(item) {
	item.disable_physics()
	
	item.x = room_width + 500
	
	bashing = item
	
	disable_controls()
	disable_gravity()
	
	vertical_speed = 0
	horizontal_speed = 0
})

bash = method(self, function(dir) {
	enable_controls()
	enable_gravity()
	
	bashing.enable_physics()
	
	static BASH_MOMENTUM = 90
	
	var _momentum_x = lengthdir_x(BASH_MOMENTUM, dir),
		_momentum_y = lengthdir_y(BASH_MOMENTUM, dir)
		
	bashing.x = x + lengthdir_x(100, dir)
	bashing.y = y + lengthdir_y(100, dir)
		
	bashing.transmit_momentum(_momentum_x * 5/8, false, TransmitMomentumType.BASH)
	bashing.transmit_momentum(_momentum_y * 5/8, true, TransmitMomentumType.BASH)
	
	transmit_momentum(_momentum_x * -3/8, false, TransmitMomentumType.BASH)
	transmit_momentum(_momentum_y * -3/8, true, TransmitMomentumType.BASH)
	
	bashing = noone
})

stop_dash = method(self, function() {
	enable_air_drag()
	enable_gravity()
	enable_controls()
	dashing = false
	ground_pounding = false
	
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