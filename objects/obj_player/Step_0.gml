invincibility--

step_timer--

screen_transition = scr_ease_value(
	screen_transition, 
	start_transition ? 100 : 0,
	6,
	true
)

if(invincibility > 0) {
	ui_transparency += 10
}

visual_health_perc = scr_ease_value(
	visual_health_perc,
	global.persistent_player_data.hp / 4 * 100,
	10,
	true
)

if(inaction_timer > 120) {
	ui_transparency = scr_ease_value(ui_transparency, 100, 2)
} else {
	ui_transparency = scr_ease_value(ui_transparency, 0, 5)
}

var _currently_wall_sliding = false

if (!controls_disabled) {
	var held_right = keyboard_check(ord("D")),
		held_left = keyboard_check(ord("A"))
	// EITHER OR
	if(!held_right ^^ !held_left) {
		var input_sign = held_right - held_left,
			h_dir = sign(horizontal_speed),
			h_abs = abs(horizontal_speed)
		
		inaction_timer = 0
			
		var dash_max = abs(input_sign * 15)
		
		if(h_abs < dash_max && input_sign == h_dir) {
			horizontal_speed += input_sign * 5
		} else if(input_sign != h_dir && bottom_collision) {
			horizontal_speed = input_sign * 5
		} else if(h_abs < dash_max * 1.2 && !bottom_collision) {
			horizontal_speed += input_sign * max(5, h_abs/5)
		}
		
		if(bottom_collision) {
			facing_left = held_left
			
			if(step_timer < 0) {
				step_timer = 15
				scr_play_sound(
					choose(
						snd_step_1,
						snd_step_2,
						snd_step_3,
						snd_step_4
					)
				)
			}
		}
		
		if (left_collision || right_collision) {
			vertical_speed = scr_ease_value(
				vertical_speed, 
				5,
				max(1 * (slide_effectiveness / max_slide_effectiveness), 0)
			)
	
			if(!bottom_collision) {
				if(!audio_is_playing(snd_wall_slide)) scr_play_sound(snd_wall_slide)
			
				_currently_wall_sliding = true
			
				part_particles_create(
					star_sys,
					left_collision ? bbox_left : bbox_right,
					y,
					part_type,
					choose(0, 0, 0, 1)
				)
			}
			
			slide_effectiveness--
		}
	} else if(bottom_collision) {
		horizontal_speed = scr_ease_value(horizontal_speed, 0, 5, true, 1)
		
		inaction_timer++
	} else {
		// falling
		inaction_timer = 0
	}
	
	var pressed_down = keyboard_check_pressed(ord("S"))
	if(pressed_down && dash_cooldown < 0) {
		inaction_timer = 0
		dash(270)
	}
}

if(!_currently_wall_sliding && audio_is_playing(snd_wall_slide)) scr_stop_sound(snd_wall_slide)

if(!dashing) dash_cooldown--

event_inherited()