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
			
			run_headless_animation(
				new ParallelCombinedAnimation([
					new DrawRectangleAnimation(
						bbox_left,
						y - 10,
						bbox_left - 100,
						y + 10
					),
					new WaitAnimation(3)
				]),
				x,
				y,
				depth - 1
			)
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
			
			run_headless_animation(
				new ParallelCombinedAnimation([
					new DrawRectangleAnimation(
						bbox_right,
						y - 10,
						bbox_right + 100,
						y + 10
					),
					new WaitAnimation(3)
				]),
				x,
				y,
				depth - 1
			)
		}
		
		var _dir = facing_left ? 150 : 30
		
		var ATTACK_POWER = 15,
			_momentum_x = lengthdir_x(ATTACK_POWER, _dir),
			_momentum_y = lengthdir_y(ATTACK_POWER, _dir)
		
		for (var i = 0; i < _collision_count; ++i) {
			var _item = _list[| i]
			
			_item.transmit_momentum(_momentum_x, false, TransmitMomentumType.ATTACK)
			_item.transmit_momentum(_momentum_y, true, TransmitMomentumType.ATTACK)
		}
		
		ds_list_destroy(_list)
		
		alarm[11] = 20
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
			
			run_headless_animation(
				new ParallelCombinedAnimation([
					new DrawRectangleAnimation(
						bbox_left,
						y - 50,
						bbox_left - 150,
						y + 50
					),
					new WaitAnimation(3)
				]),
				x,
				y,
				depth - 1
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
			
			run_headless_animation(
				new ParallelCombinedAnimation([
					new DrawRectangleAnimation(
						bbox_right,
						y - 50,
						bbox_right + 150,
						y + 50
					),
					new WaitAnimation(3)
				]),
				x,
				y,
				depth - 1
			)
		}
		
		var _dir = facing_left ? 100 : 80
		
		var ATTACK_POWER = 35,
			_momentum_x = lengthdir_x(ATTACK_POWER, _dir),
			_momentum_y = lengthdir_y(ATTACK_POWER, _dir)
		
		for (var i = 0; i < _collision_count; ++i) {
			var _item = _list[| i]
			
			_item.transmit_momentum(_momentum_x, false, TransmitMomentumType.ATTACK)
			_item.transmit_momentum(_momentum_y, true, TransmitMomentumType.ATTACK)
		}
		
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
			
		run_headless_animation(
			new ParallelCombinedAnimation([
				new DrawRectangleAnimation(
					bbox_left + 30,
					y - 150,
					bbox_left - 150,
					y + 150
				),
				new WaitAnimation(3)
			]),
			x,
			y,
			depth - 1
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
		run_headless_animation(
			new ParallelCombinedAnimation([
				new DrawRectangleAnimation(
					bbox_right - 30,
					y - 150,
					bbox_right + 150,
					y + 150
				),
				new WaitAnimation(3)
			]),
			x,
			y,
			depth - 1
		)
	}
		
	var _dir = facing_left ? 215 : -35
	
	vertical_speed = max(-14, vertical_speed - 18)
	horizontal_speed *= -0.2
		
	var ATTACK_POWER = 45,
		_momentum_x = lengthdir_x(ATTACK_POWER, _dir),
		_momentum_y = lengthdir_y(ATTACK_POWER, _dir)
		
	for (var i = 0; i < _collision_count; ++i) {
		var _item = _list[| i]
			
		_item.transmit_momentum(_momentum_x, false, TransmitMomentumType.ATTACK)
		_item.transmit_momentum(_momentum_y, true, TransmitMomentumType.ATTACK)
	}
		
	ds_list_destroy(_list)
		
	alarm[11] = 30
	#endregion
}