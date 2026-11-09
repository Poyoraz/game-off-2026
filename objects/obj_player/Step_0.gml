invincibility--

if (!controls_disabled) {
	var held_right = keyboard_check(ord("D")),
		held_left = keyboard_check(ord("A"))
		
	// EITHER OR
	if(!held_right ^^ !held_left) {
		var input_sign = held_right - held_left,
			h_dir = sign(horizontal_speed),
			h_abs = abs(horizontal_speed)
			
		var dash_max = abs(input_sign * 15)
		
		if(h_abs < dash_max && input_sign == h_dir) {
			horizontal_speed += input_sign * 5
		} else if(input_sign != h_dir && bottom_collision) {
			horizontal_speed = input_sign * 5
		} else if(h_abs < dash_max * 1.2 && !bottom_collision) {
			horizontal_speed += input_sign * max(5, h_abs/5)
		}
		
		if (left_collision || right_collision) {
			vertical_speed = scr_ease_value(
				vertical_speed, 
				5,
				max(1 * (slide_effectiveness / max_slide_effectiveness), 0)
			)
			
			slide_effectiveness--
		}
	} else if(bottom_collision) {
		horizontal_speed = scr_ease_value(horizontal_speed, 0, 5, true, 1)
	}
}

if(!dashing) dash_cooldown--

event_inherited()