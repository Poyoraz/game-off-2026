function scr_readjust_song(){
	if(scr_get_current_song() == noone) return;
	
	audio_sound_gain(
		sound_ref,
		gain,
		1000
	)
	
	audio_sound_pitch(
		sound_ref,
		pitch
	)
	
	audio_sound_loop(
		sound_ref,
		loops
	)
}