if(controls_disabled) return;
if(!scr_hook_head_attached()) return;

if(bottom_collision) {
	if(alarm[11] == -1) {
		#region FIRST SWING
		attack_combo_counter = 1
		
		var _list = ds_list_create()
		
		var _collision_count
		
		if(facing_left) {
			_collision_count = collision_rectangle_list(
				bbox_left,
				y - 10,
				bbox_left - 100,
				y + 10,
				obj_physics_item,
				false,
				true,
				_list,
				false
			)
			
			horizontal_speed -= 5
		} else {
			_collision_count = collision_rectangle_list(
				bbox_right,
				y - 10,
				bbox_right + 100,
				y + 10,
				obj_physics_item,
				false,
				true,
				_list,
				false
			)
			
			horizontal_speed += 5
		}
		
		var _dir = facing_left ? 150 : 30
		
		var ATTACK_POWER = 15,
			_momentum_x = lengthdir_x(ATTACK_POWER, _dir),
			_momentum_y = lengthdir_y(ATTACK_POWER, _dir)
		
		for (var i = 0; i < _collision_count; ++i) {
			var _item = _list[| i]
			
			attack(_item, ATTACK_POWER, _momentum_x, _momentum_y)
		}
		
		scr_play_sound(_collision_count > 0 ? snd_light_hit : snd_light_miss)
		
		ds_list_destroy(_list)
		
		alarm[11] = 25
		#endregion
	} else if(attack_combo_counter == 1) {	
		#region SECOND SWING
		var _list = ds_list_create()
		
		var _collision_count
		
		if(facing_left) {
			_collision_count = collision_rectangle_list(
				bbox_left,
				y - 50,
				bbox_left - 150,
				y + 50,
				obj_physics_item,
				false,
				true,
				_list,
				false
			)
		} else {
			_collision_count = collision_rectangle_list(
				bbox_right,
				y - 50,
				bbox_right + 150,
				y + 50,
				obj_physics_item,
				false,
				true,
				_list,
				false
			)
		}
		
		var _dir = facing_left ? 100 : 80
		
		var ATTACK_POWER = 35,
			_momentum_x = lengthdir_x(ATTACK_POWER, _dir),
			_momentum_y = lengthdir_y(ATTACK_POWER, _dir)
		
		for (var i = 0; i < _collision_count; ++i) {
			var _item = _list[| i]
			
			attack(_item, ATTACK_POWER, _momentum_x, _momentum_y)
		}
		
		scr_play_sound(_collision_count > 0 ? snd_medium_hit : snd_medium_miss)
		
		ds_list_destroy(_list)
		
		alarm[11] = 8
		attack_combo_counter = 2
		#endregion
	}
} else if(alarm[11] == -1) {
	#region AERIAL SWING
	var _list = ds_list_create()
		
	var _collision_count
		
	if(facing_left) {
		_collision_count = collision_rectangle_list(
			bbox_left + 30,
			y - 150,
			bbox_left - 150,
			y + 150,
			obj_physics_item,
			false,
			true,
			_list,
			false
		)
	} else {
		_collision_count = collision_rectangle_list(
			bbox_right - 30,
			y - 150,
			bbox_right + 150,
			y + 150,
			obj_physics_item,
			false,
			true,
			_list,
			false
		)
	}
	
	vertical_speed = max(-14, vertical_speed - 18)
	horizontal_speed *= -0.2
		
	var _dir = facing_left ? 215 : -35
	var _g_dir = facing_left ? 155 : 25
		
	var AERIAL_ATTACK_POWER = 55,
		_a_momentum_x = lengthdir_x(AERIAL_ATTACK_POWER, _dir),
		_a_momentum_y = lengthdir_y(AERIAL_ATTACK_POWER, _dir)
		
	var GROUNDED_ATTACK_POWER = 25,
		_g_momentum_x = lengthdir_x(GROUNDED_ATTACK_POWER, _g_dir),
		_g_momentum_y = lengthdir_y(GROUNDED_ATTACK_POWER, _g_dir)
		
	for (var i = 0; i < _collision_count; ++i) {
		var _item = _list[| i]
			
		if(_item.bottom_collision) {
			attack(_item, GROUNDED_ATTACK_POWER, _g_momentum_x, _g_momentum_y)	
		} else {
			attack(_item, AERIAL_ATTACK_POWER, _a_momentum_x, _a_momentum_y, 10)
		}
	}
	
	scr_play_sound(_collision_count > 0 ? snd_heavy_hit : snd_heavy_miss)
		
	ds_list_destroy(_list)
	
	attack_combo_counter = 3
		
	alarm[11] = 30
	#endregion
}