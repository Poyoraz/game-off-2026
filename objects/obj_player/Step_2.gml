event_inherited()

if (bottom_collision && jump_buffer > 0) {
	vertical_speed = jump_height
	inaction_timer = 0
}else if ((left_collision || right_collision) && jump_buffer > 0) {
	vertical_speed = jump_height-10
	horizontal_speed = 30*(left_collision-right_collision)
} else if(bottom_collision) {
	// STANDING ON GROUND
	coyote_timer = max_coyote_time
	slide_effectiveness = max_slide_effectiveness
} else {
	coyote_timer--
	jump_buffer--
}

if(keyboard_check_pressed(vk_space) && !controls_disabled) {
	if (coyote_timer > 0) {
		vertical_speed = jump_height
		coyote_timer = -1
		
		attack_combo_counter = 0
		alarm[11] = 0
	} else if ((left_collision || right_collision) && vertical_speed >= 0) {
		vertical_speed = jump_height+5
		horizontal_speed = 30*(left_collision-right_collision)
		
		facing_left = !facing_left
	} else {
		jump_buffer = max_jump_buffer
	}
}

if (keyboard_check_released(vk_space) && !controls_disabled && vertical_speed < -5) {
	vertical_speed = -5
}