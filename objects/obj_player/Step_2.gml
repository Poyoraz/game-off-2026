event_inherited()

if (bottom_collision && jump_buffer > 0) {
	vertical_speed = jump_height
}else if ((left_collision || right_collision) && jump_buffer > 0) {
	vertical_speed = jump_height-10
	horizontal_speed = 30*(left_collision-right_collision)
} else if(bottom_collision) {
	coyote_timer = max_coyote_time
} else {
	coyote_timer--
	jump_buffer--
}

if(keyboard_check_pressed(vk_space)) {
	if (coyote_timer > 0) {
		vertical_speed = jump_height
		coyote_timer = -1
	} else if (left_collision || right_collision) {
		vertical_speed = jump_height+5
		horizontal_speed = 30*(left_collision-right_collision)
	} else {
		jump_buffer = max_jump_buffer
	}
}

if (keyboard_check_released(vk_space) && vertical_speed < -5) {
	vertical_speed = -5
}