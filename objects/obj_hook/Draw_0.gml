var _px = obj_player.x,
	_py = obj_player.y,
	_hook_butt_x = x - lengthdir_x(50, direction),
	_hook_butt_y = y - lengthdir_y(50, direction),
	_dir = point_direction(_px, _py, _hook_butt_x, _hook_butt_y),
	// Remove ~1 link to stop extra drawing
	_dist = point_distance(_px, _py, _hook_butt_x, _hook_butt_y) - 60

for (var i = 0; i < _dist; i += CHAIN_STEP_SIZE * 2) {
    draw_sprite_ext(
		spr_chain_link_face,
		-1,
		_hook_butt_x - lengthdir_x(i, _dir),
		_hook_butt_y - lengthdir_y(i, _dir),
		0.15,
		0.15,
		_dir,
		c_white,
		1
	)
}

for (var i = CHAIN_STEP_SIZE; i < _dist; i += CHAIN_STEP_SIZE * 2) {
    draw_sprite_ext(
		spr_chain_link_side,
		-1,
		_hook_butt_x - lengthdir_x(i, _dir),
		_hook_butt_y - lengthdir_y(i, _dir),
		0.15,
		0.15,
		_dir,
		c_white,
		1
	)
}