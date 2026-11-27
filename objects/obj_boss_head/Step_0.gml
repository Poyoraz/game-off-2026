// Inherit the parent event
event_inherited();

var _x = x,
	_y = y

if(current_phase > 0 && !phase_break) {
	if(shockwave_timer == 1200) {
		scr_play_sound(charge_sounds[current_phase - 1])
	}
	
	shockwave_timer -= 1 + sqr(current_phase) / 2
	
	if(shockwave_timer == 0) {
		scr_stop_sound(charge_sounds[current_phase - 1])
		
		scr_play_sound(
			choose(
				snd_shockwave_1,
				snd_shockwave_2,
				snd_shockwave_3
			)
		)
		
		run_headless_animation(
			screen_shake(15),
			x,
			y,
			depth - 1
		)
	} else if(shockwave_timer < 0) {
		shockwave_radius += 50
		
		var _inst_count = instance_number(obj_physics_item)
		
		for (var i = 0; i < _inst_count; ++i) {
		    var _inst = instance_find(obj_physics_item, i)
			
			if(ds_list_find_index(shockwave_list, _inst) > -1) continue
			
			var _dist = point_distance(
				_x,
				_y,
				_inst.x,
				_inst.y
			)
	
			if(shockwave_radius - 60 > _dist || shockwave_radius < _dist) continue
			
			ds_list_add(shockwave_list, _inst)
	
			var _dir = point_direction(
				_x,
				_y,
				_inst.x,
				_inst.y
			)
			
			var SHOCKWAVE_STRENGTH = 50
			
			var _mx = lengthdir_x(SHOCKWAVE_STRENGTH, _dir),
				_my = lengthdir_y(SHOCKWAVE_STRENGTH, _dir)
				
			if(object_is_ancestor(_inst.object_index, obj_enemy)) {
				_inst.brain_disabled_timer = 15
			}
				
			_inst.transmit_momentum(_mx, false, TransmitMomentumType.SHOCKWAVE)
			_inst.transmit_momentum(_my, true, TransmitMomentumType.SHOCKWAVE)
			
			if(
				_inst.object_index == obj_destructable_terrain
				&& current_phase == 3
				&& choose(true, false, false, false)
			) {
				_inst.alarm[0] = 1
			}
		}
		
		if(shockwave_radius > room_width) {
			shockwave_timer = 1200
			shockwave_radius = 0
			
			ds_list_clear(shockwave_list)
		}
	} else if(shockwave_timer > 100) {
		var _angle = random(360),
			_dist = 500,
			_spawn_x = x + lengthdir_x(_dist, _angle),
			_spawn_y = y + lengthdir_y(_dist, _angle)
			
			var _dir_to_center = point_direction(_spawn_x, _spawn_y, x, y)
			part_type_direction(p_absorb, _dir_to_center, _dir_to_center, 0, 0)

			part_particles_create(part_sys, _spawn_x, _spawn_y, p_absorb, 1)

	}
}
