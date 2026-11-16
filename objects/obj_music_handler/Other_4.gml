if(_initialized) { 
	exit 
}

_initialized = true
persistent = true

var _instance_number = instance_number(obj_music_handler)

for (var i = 0; i < _instance_number; ++i) {
    var _instance = instance_find(obj_music_handler, i)
	
	// IGNORE SELF
	if(_instance.id == self.id) continue
	
	var _prev_song = scr_get_audio_playing(_instance),
		_new_song = scr_get_current_song()
		
	if(_prev_song == _new_song) {
		sound_ref = _instance.sound_ref
		scr_readjust_song()
	} else {
		scr_transition_song(_instance)
	}
	
	instance_destroy(_instance)
	
	exit
}

// NO PREVIOUS INSTANCES, PLAY SONG
scr_handler_play_song(
	scr_get_current_song()
)