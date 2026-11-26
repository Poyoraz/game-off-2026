// Inherit the parent event
event_inherited();

transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {
	if(type == TransmitMomentumType.INTERRUPT_DASH) {
		scr_play_sound(snd_metal_stomp)
		
		return transmit_momentum(
			momentum * 2,
			vertical,
			TransmitMomentumType.COLLISION
		)
	}
	
	var transferred_speed = (momentum/weight)// * 0.85
	
	if(vertical) {
		if(abs(transferred_speed) > minimum_momentum_for_vertical_movement)
			vertical_speed += transferred_speed
	} else {
		if(abs(transferred_speed) > minimum_momentum_for_horizontal_movement)
			horizontal_speed += transferred_speed
	}
})