// Inherit the parent event
event_inherited();

transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {
	if(type == TransmitMomentumType.COLLISION && abs(momentum) > resistance) {
		scr_play_sound(
			choose(
				snd_rock_fall,
				snd_rock_fall_2
			)
		)
		
		instance_destroy()
	}
})