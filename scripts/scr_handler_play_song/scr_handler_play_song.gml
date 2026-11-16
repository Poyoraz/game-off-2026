function scr_handler_play_song(song){
	if(song == noone) {
		sound_ref = undefined
		return;
	}
	
	sound_ref = audio_play_sound(
		song,
		priority,
		loops,
		gain,
		undefined,
		pitch
	)
}