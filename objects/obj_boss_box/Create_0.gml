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
	
	if(type == TransmitMomentumType.COLLISION && abs(momentum) > 20) {
		scr_play_sound(
			choose(snd_metal_impact, snd_metal_impact_2, snd_metal_impact_3)
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

_inner_physics_item_on_collide = on_collide
on_collide = method(self, function(collidee, vertical = false) {
	_inner_physics_item_on_collide(collidee, vertical)
})