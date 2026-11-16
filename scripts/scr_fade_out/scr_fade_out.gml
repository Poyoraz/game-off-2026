function scr_fade_out(sound_ref){
	audio_sound_gain(
		sound_ref,
		0,
		transition_time
	)
		
	var _t_src = time_source_create(
		time_source_game,
		transition_time / 1000,
		time_source_units_seconds,
		function(s_ref) {
			audio_stop_sound(s_ref)
		},
		[sound_ref],
		1
	)
		
	time_source_start(_t_src)
}