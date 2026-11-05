if (!disable_controls) {
	var held_right = keyboard_check(ord("D")),
		held_left = keyboard_check(ord("A"))
		
	// EITHER OR
	if(!held_right ^^ !held_left) {
		var input_sign = keyboard_check(ord("D")) - keyboard_check(ord("A")),
			h_dir = sign(horizontal_speed),
			h_abs = abs(horizontal_speed)
			
		var dash_max = abs(input_sign * 15)
		
		if(h_abs < dash_max && input_sign == h_dir) {
			horizontal_speed += input_sign * 5
			show_debug_message("add speed")
		} else if(input_sign != h_dir && bottom_collision) {
			horizontal_speed = input_sign * 5
			show_debug_message("change speed")
		} else if(h_abs < dash_max) {
			horizontal_speed += input_sign * 5
		}
	}
}

event_inherited()