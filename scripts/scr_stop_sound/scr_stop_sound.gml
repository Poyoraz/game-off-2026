function scr_stop_sound(sound){
	if(instance_exists(obj_sound_handler)) {
		obj_sound_handler.stop_sound(sound)
	} else {
		audio_stop_sound(
			sound
		)
	}
}