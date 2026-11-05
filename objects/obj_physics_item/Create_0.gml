bottom_collision = false
top_collision = false
left_collision = false
right_collision = false

transmit_momentum = method(self, function(momentum, vertical = false) {
	var transferred_speed = (momentum/weight)// * 0.85
	
	if(vertical) {
		if(abs(transferred_speed) > minimum_momentum_for_vertical_movement)
			vertical_speed += transferred_speed
	} else {
		if(abs(transferred_speed) > minimum_momentum_for_horizontal_movement)
			horizontal_speed += transferred_speed
	}
})

get_momentum = method(self, function(vertical = false) {
	return vertical
		? weight * vertical_speed
		: weight * horizontal_speed
})