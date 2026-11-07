event_inherited()

if(bottom_collision) {
	coyote_timer = max_coyote_time
} else {
	coyote_timer--
	jump_buffer--
}

if(keyboard_check_direct(vk_space)) {
	if ((bottom_collision && jump_buffer > 0) || coyote_timer > 0) {
		vertical_speed = -35
		coyote_timer = -1
	} else {
		jump_buffer = 4
	}
}

if (keyboard_check_released(vk_space) && vertical_speed < -5) {
	vertical_speed = -5
}