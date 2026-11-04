event_inherited()

if(bottom_collision) {
	grounded_timer = coyote_time
} else {
	grounded_timer--
}

if(keyboard_check_pressed(vk_space) && grounded_timer > 0) { 
	vertical_speed = -30
	grounded_timer = -1
}