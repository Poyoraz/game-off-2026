play_sound = method(self, function(sound) {
	audio_play_sound(
		sound,
		1,
		false,
		gain,
		0,
		pitch
	)
})

stop_sound = method(self, function(sound) {
	audio_stop_sound(
		sound
	)
})