var _px = obj_player.x,
	_py = obj_player.y,
	_hook_butt_x = x - lengthdir_x(50, direction),
	_hook_butt_y = y - lengthdir_y(50, direction),
	_dir = point_direction(_px, _py, _hook_butt_x, _hook_butt_y),
	// Remove ~1 link to stop extra drawing
	_dist = point_distance(_px, _py, _hook_butt_x, _hook_butt_y),
	skip_steps = max(1, (timer - _dist / 180) * 2)
	
var _chain_points = []
	
var i = 60
while(i < _dist) {
	var _perc = i / _dist,
		_angle = _perc * 360,
		_sin = dsin(_angle),
		// APPROXIMATION, WORK ON THIS
		_tangent_angle = darctan(dcos(_angle)) + _dir 
		
	var _y_offset = path_get_y(path_curve, _perc) * min(_dist / 720, power(timer, 2) / 135) * curve_randomness
	
	var _curr_x = _px + lengthdir_x(i, _dir) + lengthdir_x(_y_offset, _dir + 90),
		_curr_y = _py + lengthdir_y(i, _dir) + lengthdir_y(_y_offset, _dir + 90)
	
	var _prev = array_last(_chain_points)
	
	if(!is_undefined(_prev)) {
		_prev.dir = point_direction(_prev.x, _prev.y, _curr_x, _curr_y)
	}
	
	array_push(
		_chain_points,
		{
			x: _curr_x,
			y: _curr_y,
			dir: 0
		}
	)
		
	var _next_i = i + dcos(angle_difference(_tangent_angle, _dir)) * CHAIN_STEP_SIZE
	i = _next_i
}

for (var j = 0; j < array_length(_chain_points) - skip_steps; j += 2) {
	var _curr = _chain_points[j]
	
    draw_sprite_ext(
		spr_chain_link_face,
		-1,
		_curr.x,
		_curr.y,
		0.15,
		0.15,
		_curr.dir,
		c_white,
		1
	)
	
}

for (var j = 1; j < array_length(_chain_points) - skip_steps; j += 2) {
	var _curr = _chain_points[j]
	
    draw_sprite_ext(
		spr_chain_link_side,
		-1,
		_curr.x,
		_curr.y,
		0.15,
		0.15,
		_curr.dir,
		c_white,
		1 
	)
}

if(skip_steps > array_length(_chain_points) - 3) {
	instance_destroy()
	return
}

var _last_idx = array_length(_chain_points) - skip_steps
var _last = _chain_points[_last_idx]

draw_sprite_ext(
	sprite_index,
	-1,
	_last.x,
	_last.y,
	0.15,
	0.15,
	_chain_points[_last_idx - 1].dir,
	c_white,
	1
)