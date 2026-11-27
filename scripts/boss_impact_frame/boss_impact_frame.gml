function boss_impact_frame(duration){
	
	static WHITEN_EFFECT = __get_whiten_fx()
	static DARKEN_EFFECT = __get_darken_fx()
	static SHAKE_EFFECT = __get_shake_fx()
	
	var wait = new WaitAnimation(duration)
	
	// I AM A VERY LAZY PERSON DO NOT BE LIKE ME
	wait.action = method(wait, function() {
		static shape = particle_get_info(prs_boss_scream).emitters[0].parttype.ind
		
		duration--
		
		part_particles_create(
			obj_boss_head.part_sys,
			obj_boss_head.x,
			obj_boss_head.y,
			shape,
			5
		)
	})
	
	return new ParallelCombinedAnimation([
		wait,
		new RunFunctionAnimation(function() {
			scr_play_sound(snd_boss_scream)
			
			if(!instance_exists(obj_music_handler)) {
				var _music = instance_create_depth(-100, -100, -100, obj_music_handler, {
					ambient_theme: mus_final_boss
				})
				
				with(_music) {
					event_perform(ev_other, ev_room_start)
				}
			}
		}),
		new LinearCombinedAnimation([
			new WaitAnimation(duration * 3/4),
			new RunFunctionAnimation(function() {
				obj_player.start_transition = true
			}),
			new WaitAnimation(duration * 1/4),
			new RunFunctionAnimation(function() {
				obj_player.start_transition = false
			}),
		]),
		new BaseAnimation(
			function() {
			},
			function() {
				return true
			},
			function() {
				layer_set_fx("Instances", boss_impact_frame.DARKEN_EFFECT)
				layer_set_fx("Player", boss_impact_frame.DARKEN_EFFECT)
				layer_set_fx("Background", boss_impact_frame.WHITEN_EFFECT)
				layer_set_fx("ShakeLayer", boss_impact_frame.SHAKE_EFFECT)
			},
			function() {
				layer_clear_fx("Instances")
				layer_clear_fx("Player")
				layer_clear_fx("Background")
				layer_clear_fx("ShakeLayer")
				part_particles_clear(obj_boss_head.part_sys)
			}
		),
		new BaseAnimation(
			function() {
			},
			function() {
				return true
			},
			function() {
			},
			function() {
			}
		),
	])
}

function __get_whiten_fx() {
	var _fx = fx_create("_filter_contrast")
	fx_set_parameter(_fx, "g_ContrastIntensity", 2)
	fx_set_parameter(_fx, "g_ContrastBrightness", 2)
	fx_set_single_layer(_fx, true)
	
	return _fx
}

function __get_darken_fx() {
	var _fx = fx_create("_filter_tintfilter")
	fx_set_parameter(_fx, "g_TintCol", [0, 0, 0, 1])
	fx_set_single_layer(_fx, true)
	
	return _fx
}

function __get_shake_fx() {
	var _fx = fx_create("_filter_screenshake")
	fx_set_parameter(_fx, "g_ShakeSpeed", 3)
	
	return _fx
}