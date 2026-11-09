if(other.object_index == obj_enemy) exit

if(other.object_index == obj_player) {
	other.damage()
}

var _x_dir = lengthdir_x(15, direction),
	_y_dir = lengthdir_y(15, direction) 

other.transmit_momentum(_x_dir, false, TransmitMomentumType.BULLET)
other.transmit_momentum(_y_dir, true, TransmitMomentumType.BULLET)

instance_destroy()
