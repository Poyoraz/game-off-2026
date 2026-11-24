event_inherited()

follow_buffer = 30 // slight buffer to prevent jitter when at follow distance
move_dir = 0


brain = noone
current_state = EnemyStates.NONE

scr_change_enemy_state(default_enemy_state)

projector = noone

__projector_blocked = false

weapon = new WeaponConstructor()

hp = max_hp
_tolerated_pain_this_frame = 0

hit_lag = 0

ui_transparency = 0
visual_health_perc = 100
mouse_on_enemy = false

on_death = method(self, function() {
	scr_play_sound(death_sound)
})

check_for_death = method(self, function() {
	if(hp > 0) return false
	if(hit_lag > 0) return false
	
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
	
	if(instance_exists(projector) && !__projector_blocked) return;
	
	ui_transparency = 400
	
	hp -= _pain
	
	if(_pain > 60 && hp <= 0) {
		run_headless_animation(
			impact_frame(15),
			x,
			y,
			-999
		)
		
		scr_play_sound(snd_metal_stomp)
		
		hit_lag = 15
	}
	
	run_headless_animation(
		upward_fading_text(
			scribble($"[c_red][fnt_damage]-{round(_pain)}")
				.align(fa_center, fa_middle),
			1,
			90
		),
		x,
		y,
		depth - 1
	)
	
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

on_grapple_hook = method(self, function() {
	if(is_armored) return noone
	
	return self
})

with(obj_music_handler) {
	update()
}

if(is_shielded) {
	var _projector = instance_nearest(x, y, obj_shield_projector)
	
	if(instance_exists(_projector)) {
		projector = _projector
		
		alarm[0] = 5
	} else {
		is_shielded = false
	}
}