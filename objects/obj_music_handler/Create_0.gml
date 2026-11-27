sound_ref = undefined

_initialized = false


update = method(self, function() {
	var _prev_song = scr_get_audio_playing(self),
		_new_song = scr_get_current_song()
		
	show_debug_message([_prev_song, _new_song])
	if(_prev_song != _new_song) {
		scr_slide_song(self)
	}
})