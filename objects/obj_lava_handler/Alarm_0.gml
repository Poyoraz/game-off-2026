///@desc Damage Loop

if(timer < 0) {
	if(obj_player.y > room_height - rise_amount) {
		obj_player.damage()
		
		obj_player.transmit_momentum(-75, true, TransmitMomentumType.LAVA_DAMAGE)
	}
}

alarm[0] = 3