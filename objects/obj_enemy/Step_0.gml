// Inherit the parent event
event_inherited();


if (!controls_disabled) {
	if(move_dir != 0) {
		var h_dir = sign(horizontal_speed),
			h_abs = abs(horizontal_speed)
			
		var dash_max = abs(move_dir * 12)
		
		if(h_abs < dash_max && move_dir == h_dir) {
			horizontal_speed += move_dir * 2
		} else if(move_dir != h_dir && bottom_collision) {
			horizontal_speed = move_dir * 2
		} else if(!bottom_collision) {
			horizontal_speed += move_dir * max(5, h_abs/5)
		}
	} else if(bottom_collision) {
		horizontal_speed = scr_ease_value(horizontal_speed, 0, 5, true, 1)
	}
}