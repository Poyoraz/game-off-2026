function scr_play_sound(sound){
	if(instance_exists(obj_sound_handler)) {
		obj_sound_handler.play_sound(sound)
	} else {
		audio_play_sound(
			sound,
			1,
			false
		)
	}
}