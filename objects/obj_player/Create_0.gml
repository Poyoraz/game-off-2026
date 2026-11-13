event_inherited()

max_coyote_time = 6
max_jump_buffer = 6

invincibility = 0

max_slide_effectiveness = 120
slide_effectiveness = max_slide_effectiveness

coyote_timer = max_coyote_time
jump_buffer = 0
jump_height = -35

_orig_grav = grav
_orig_drag = air_drag

dashing = false
ground_pounding = false
max_dash_cooldown = 180
dash_cooldown = 0

controls_disabled = false

disable_controls = method(self, function() {
	controls_disabled = true
})

enable_controls = method(self, function() {
	controls_disabled = false
})

damage = method(self, function() {
	if(invincibility > 0) return;
	
	global.persistent_player_data.hp--
	invincibility = invincibility_duration
})

player_cast = []

_physics_item_on_collide = on_collide

on_collide = method(self, function(collidee, vertical) {
	if(dashing) interrupt_dash(collidee)
	
	if(object_is_ancestor(collidee.object_index, obj_terrain)) {
		collidee.on_collided(self)
	}
	
	_physics_item_on_collide(collidee, vertical)
})

dash = method(self, function(_dir) {
	coyote_timer = 0

	horizontal_speed = lengthdir_x(40, _dir)
	
	vertical_speed = max(-15, lengthdir_y(40, _dir))

	disable_air_drag()
	disable_gravity()
	disable_controls()
	dashing = true
	if(_dir == 270) ground_pounding = true

	dash_cooldown = max_dash_cooldown

	alarm[0] = 15
})

interrupt_dash = method(self, function(collidee) {
	var _h_dir = horizontal_speed
	
	if(ground_pounding) create_shockwave(collidee)
	
	var _horizontal_momentum = get_momentum(),
		_vertical_momentum = get_momentum(true)
		
	collidee.transmit_momentum(_horizontal_momentum * 1.2, false, TransmitMomentumType.INTERRUPT_DASH)
	collidee.transmit_momentum(_vertical_momentum * 1/4 , true, TransmitMomentumType.INTERRUPT_DASH)
	
	alarm[0] = -1
	stop_dash()
	
	vertical_speed = -10
	horizontal_speed *= -1
})

create_shockwave = method(self, function(collidee) {
	var colliding_list = ds_list_create()
	
	var _precollide_count = collision_line_list(
		bbox_left, 
		collidee.bbox_top + 1, 
		bbox_right, 
		collidee.bbox_top + 1,
		obj_collidable, false, true,
		colliding_list,
		false
	)
	
	var _precollide_list = ds_list_to_array(colliding_list)
	ds_list_destroy(colliding_list)
	
	for (var i = 0; i < _precollide_count; ++i) {
	    var _item = _precollide_list[i]
		
		_item.transmit_momentum(120, true, TransmitMomentumType.SHOCKWAVE)
	}
	
	array_push(_precollide_list, id)
	
	for (var i = 0; i < 2; ++i) {
	    var _dir =  i * 180
		
		instance_create_depth(
			x,
			collidee.bbox_top,
			depth - 1,
			obj_shockwave,
			{
				direction: _dir,
				initial_items: _precollide_list
			}
		)
	}
})

bashing = noone
hook_bash = false
set_bash = method(self, function(item) {
	item.disable_physics()
	
	if(object_is_ancestor(item.object_index, obj_hookable_area) || item.object_index == obj_hookable_area) {
		x = item.x + lengthdir_x(75, item.x)
		y = item.y + lengthdir_y(75, item.y)
		
		hook_bash = true
	} else {
			
		item.x = room_width + 500
		
		if(item.tp_to_while_bashing) {
			warp(
				item.xprevious,
				item.yprevious,
				true
			)
		}
		
	}
	
	bashing = item
	
	disable_controls()
	disable_gravity()
	
	vertical_speed = 0
	horizontal_speed = 0
})

bash = method(self, function(dir) {
	enable_controls()
	enable_gravity()
	
	bashing.enable_physics()
	
	static BASH_MOMENTUM = 90
	
	var _momentum_x = lengthdir_x(BASH_MOMENTUM, dir),
		_momentum_y = lengthdir_y(BASH_MOMENTUM, dir)
	
	if(hook_bash) {
		warp(
			x + lengthdir_x(50, dir),
			y + lengthdir_y(50, dir)
		)
	
		transmit_momentum(_momentum_x * 1/2, false, TransmitMomentumType.BASH)
		transmit_momentum(
			max(
				-35,
				_momentum_y * 1/2
			), 
			true, 
			TransmitMomentumType.BASH
		)
	} else {
		var _x = x, _y = y
		
		warp(
			x + lengthdir_x(50, dir),
			y + lengthdir_y(50, dir)
		)
		
		bashing.x = _x
		bashing.y = _y
		
		with(bashing) {
			scr_warp_object_with_collision(
				other.x + lengthdir_x(-100, dir),
				other.y + lengthdir_y(-100, dir)
			)
		}
			
		bashing.transmit_momentum(_momentum_x * -5/8, false, TransmitMomentumType.BASH)
		bashing.transmit_momentum(_momentum_y * -5/8, true, TransmitMomentumType.BASH)
	
		transmit_momentum(_momentum_x * 3/8, false, TransmitMomentumType.BASH)
		transmit_momentum(
			// CAP UPWARDS SPEED
			max(
				-28,
				_momentum_y * 3/8
			), 
			true, 
			TransmitMomentumType.BASH
		)
	}
	
	hook_bash = false
	
	bashing = noone
})

stop_dash = method(self, function() {
	enable_air_drag()
	enable_gravity()
	enable_controls()
	dashing = false
	ground_pounding = false
	
	vertical_speed /= 4
	horizontal_speed /= 4
})

warp = method(self, scr_warp_object_with_collision)