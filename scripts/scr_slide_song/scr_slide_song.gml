function scr_slide_song(old_handler){
	var _track_pos = audio_sound_get_track_position(old_handler.sound_ref)
	
	if(audio_is_playing(old_handler.sound_ref)) {
		scr_fade_out(old_handler.sound_ref)
	}
	
	scr_handler_play_song(
		scr_get_current_song()
	)
	
	audio_sound_set_track_position(
		sound_ref,
		_track_pos
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