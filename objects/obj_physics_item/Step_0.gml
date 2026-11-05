#region VERTICAL SPEED

vertical_speed += grav

#endregion

if(lock_vertical) {
	vertical_speed = 0
}

if(lock_horizontal) {
	horizontal_speed = 0
}

var _vsp = vertical_speed
var v_dir = sign(_vsp)

if(v_dir != 0) {
	var __v_side = (v_dir == 1 ? bbox_bottom : bbox_top) + v_dir

	var _movement = 0
	
	var _drag = air_drag
	
	vertical_speed = max(0, abs(_vsp) - _drag) * v_dir
		
	repeat (min(abs(_vsp), vertical_speed_max)) {	
		var colliding = collision_line(
			bbox_left + 1, 
			__v_side + _movement, 
			bbox_right - 1, 
			__v_side + _movement, 
			obj_collidable, 0, 1
		)
		
		if(instance_exists(colliding)) {
			if(colliding.weight == infinity) {
				vertical_speed = 0
				
				break
			}
			
			var combined_momentum = get_momentum(true) + colliding.get_momentum(true)
			vertical_speed = 0
			
			transmit_momentum(3 * combined_momentum / 8, true)
			
			colliding.transmit_momentum(5 * combined_momentum / 8, true)
				
			break
		}
		
		_movement += v_dir
		
		y += v_dir
	}
}

var _hsp = horizontal_speed
var h_dir = sign(_hsp)

if(h_dir != 0) {
	var __h_side = (h_dir == 1 ? bbox_right : bbox_left) + h_dir
	
	var _movement = 0
	
	var _drag = air_drag
	
	if(bottom_collision && !unaffected_by_friction) {
		var _item = collision_line(
			bbox_left + 1, 
			bbox_bottom + 2, 
			bbox_right - 1, 
			bbox_bottom + 2, 
			obj_collidable, 0, 1
		)
		
		if(instance_exists(_item)) {
			_drag += weight * friction_multiplier * 5
		}
	}
	
	horizontal_speed = max(0, abs(_hsp) - _drag) * h_dir
	
	repeat (min(abs(_hsp), horizontal_speed_max)) {	
		var colliding = collision_line(
			__h_side + _movement, 
			bbox_top + 1, 
			__h_side + _movement, 
			bbox_bottom - 1, 
			obj_collidable, 
			0, 
			1
		)
		
		if(instance_exists(colliding)) {
			if(colliding.weight == infinity) {
				horizontal_speed = 0
				
				break
			}
			
			var combined_momentum = get_momentum()
			horizontal_speed = 0
			
			transmit_momentum(combined_momentum / 2)
			colliding.transmit_momentum(combined_momentum / 2)
				
			break
		}
		
		_movement += h_dir
		
		x += h_dir
	}
	
	if(top_collision) {
		var _item = collision_line(
			bbox_left + 1, 
			bbox_top - 2, 
			bbox_right - 1, 
			bbox_top - 2, 
			obj_collidable, 0, 1
		)
		
		var displacement = y - yprevious
		
		if(instance_exists(_item)) {
			_item.horizontal_speed = h_dir == 1
				? max(displacement, _item.horizontal_speed)
				: min(displacement, _item.horizontal_speed)
		}
	}
}