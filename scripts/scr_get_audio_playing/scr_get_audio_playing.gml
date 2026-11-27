function scr_get_audio_playing(_inst){
	var _sound_inst = _inst.sound_ref
	
	if(!audio_is_playing(_sound_inst)) return undefined
	
	return audio_sound_get_asset(_sound_inst)
}