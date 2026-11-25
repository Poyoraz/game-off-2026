var _prev_bottom_collision = bottom_collision

event_inherited()

// JUST LANDED
if(!_prev_bottom_collision && bottom_collision) {
	part_particles_create(
		star_sys,
		x,
		bbox_bottom,
		part_type,
		4
	)
	
	scr_play_sound(snd_land)
}

if (bottom_collision && jump_buffer > 0) {
	vertical_speed = jump_height
	inaction_timer = 0
	
	attack_combo_counter = 0
	alarm[11] = 0
	
	part_particles_create(
		star_sys,
		x,
		bbox_bottom,
		part_type,
		4
	)
	
	scr_play_sound(snd_jump)
} else if(bottom_collision) {
	// STANDING ON GROUND
	coyote_timer = max_coyote_time
	slide_effectiveness = max_slide_effectiveness
} else {
	coyote_timer--
	jump_buffer--
}

if(keyboard_check(vk_space) && !controls_disabled) {
	if (coyote_timer > 0) {
		inaction_timer = 0
	
		attack_combo_counter = 0
		alarm[11] = 0
	
		part_particles_create(
			star_sys,
			x,
			bbox_bottom,
			part_type,
			4
		)
		
		vertical_speed = jump_height
		coyote_timer = -1
	
		scr_play_sound(snd_jump)
	} else {
		jump_buffer = max_jump_buffer
	}
}

if(keyboard_check_pressed(vk_space)) {
	if ((left_collision || right_collision) && vertical_speed >= 0) {
		vertical_speed = jump_height+5
		horizontal_speed = 30*(left_collision-right_collision)
		
		facing_left = !facing_left
	
		scr_play_sound(
			left_collision ? snd_wall_jump_l : snd_wall_jump_r
		)
		
		part_particles_create(
			star_sys,
			x,
			bbox_bottom,
			part_type,
			4
		)
	} 
}

if (keyboard_check_released(vk_space) && !controls_disabled && vertical_speed < -5) {
	vertical_speed = -5
}