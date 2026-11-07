event_inherited()

hp = max_hp

check_for_death = method(self, function() {
	if(hp > 0) return false
	
	instance_destroy()
	return true
})

damage_check = method(self, function(_damage) {
	var damage = abs(_damage)

	if(damage <= 1) return false;
	
	if(abs(damage) < pain_tolerance) return false;
	
	hp -= damage
	
	check_for_death()
	
	return true
})

_physics_item_on_collide = on_collide
on_collide = method(self, function(collidee, vertical = false) {
	damage_check(get_momentum(vertical))
	
	_physics_item_on_collide(collidee, vertical)
})

_physics_item_trasmit_momentum = transmit_momentum
transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {
	show_debug_message([momentum, type])
	
	if(type = TransmitMomentumType.COLLISION) {
		damage_check(momentum)
		
		if(!instance_exists(self)) return;
	}
	
	_physics_item_trasmit_momentum(momentum, vertical, type)
})