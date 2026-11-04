bottom_collision = false
top_collision = false
left_collision = false
right_collision = false

transmit_momentum = method(self, function(momentum, _dir) {
	var transferred_speed = momentum/weight
	
	horizontal_speed += lengthdir_x(transferred_speed, _dir)
	vertical_speed += lengthdir_y(transferred_speed, _dir)
})