function scr_transition_song(old_handler){
	if(audio_is_playing(old_handler.sound_ref)) {
		scr_fade_out(old_handler.sound_ref)
	}
	
	scr_handler_play_song(
		scr_get_current_song()
	)
	
	audio_sound_gain(
		sound_ref,
		0,
		0
	)
	
	audio_sound_gain(
		sound_ref,
		gain,
		transition_time
	)
}