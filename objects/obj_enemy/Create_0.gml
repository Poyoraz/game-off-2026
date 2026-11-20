event_inherited()

follow_buffer = 30 // slight buffer to prevent jitter when at follow distance
move_dir = 0


brain = noone
current_state = EnemyStates.NONE

scr_change_enemy_state(default_enemy_state)

weapon = new WeaponConstructor()

hp = max_hp
_tolerated_pain_this_frame = 0

on_death = method(self, function() {
	
})

check_for_death = method(self, function() {
	if(hp > 0) return false
	
	run_headless_animation(
		new PlaySpriteAnimation(spr_realistic_explosion, 1.5),
		x,
		y,
		depth - 10
	)
	
	instance_destroy()
	return true
})

damage_check = method(self, function(_damage) {
	var damage = abs(_damage)

	_tolerated_pain_this_frame += damage
	
	return true
})

death_check = method(self, function() {
	var _pain = _tolerated_pain_this_frame
	
	_tolerated_pain_this_frame = 0
	
	if(_pain < pain_tolerance) return;
	
	hp -= _pain
	
	check_for_death()
})

_physics_item_on_collide = on_collide
on_collide = method(self, function(collidee, vertical = false) {
	damage_check(get_momentum(vertical))
	
	_physics_item_on_collide(collidee, vertical)
})

_physics_item_trasmit_momentum = transmit_momentum
transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {	
	if(type == TransmitMomentumType.COLLISION) {
		damage_check(momentum)
		
		if(!instance_exists(self)) return;
	}
	
	_physics_item_trasmit_momentum(momentum, vertical, type)
})

controls_disabled = false

disable_controls = method(self, function() {
	controls_disabled = true
})

enable_controls = method(self, function() {
	controls_disabled = false
})

with(obj_music_handler) {
	update()
}