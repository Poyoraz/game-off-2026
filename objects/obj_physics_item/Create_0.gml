bottom_collision = false
top_collision = false
left_collision = false
right_collision = false

affected_by_gravity = true
affected_by_airdrag = true

transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {
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

disable_gravity = method(self, function() {
	affected_by_gravity = false
})

enable_gravity = method(self, function() {
	affected_by_gravity = true
})

disable_air_drag = method(self, function() {
	affected_by_airdrag = false
})

enable_air_drag = method(self, function() {
	affected_by_airdrag = true
})

on_collide = method(self, function(collidee, vertical = true) {
	var momentum = get_momentum(vertical)
	if(vertical) {
		vertical_speed = 0
	} else {
		horizontal_speed = 0
	}
	
	if(collidee.weight == infinity) {
		return;
	}
			
	transmit_momentum(3 * momentum / 8, vertical)
			
	collidee.transmit_momentum(5 * momentum / 8, vertical)
})

on_grapple_pull = method(self, function(force, dir) {
	var pull_momentum = force
	
	var _h_pull = lock_vertical 
			? sign(dcos(dir)) * pull_momentum 
			: lengthdir_x(pull_momentum, dir),
		_v_pull = lock_horizontal 
			? -sign(dsin(dir)) * pull_momentum  
			: lengthdir_y(pull_momentum, dir)
		
	transmit_momentum(_h_pull)
	transmit_momentum(_v_pull, true)
})

on_grapple_hook = method(self, function() {

})