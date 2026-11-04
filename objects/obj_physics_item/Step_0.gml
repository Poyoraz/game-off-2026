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
		
	repeat (min(abs(_vsp), vertical_speed_max)) {	
		var colliding = collision_line(
			bbox_left + 1, 
			__v_side + _movement, 
			bbox_right - 1, 
			__v_side + _movement, 
			obj_collidable, 0, 1
		)
		
		if(colliding) break
		
		_movement += v_dir
		
		y += v_dir
	}
}

var _hsp = horizontal_speed
var h_dir = sign(_hsp)

if(h_dir != 0) {
	var __h_side = (h_dir == 1 ? bbox_right : bbox_left) + h_dir
	
	var _movement = 0
	
	repeat (min(abs(_hsp), horizontal_speed_max)) {	
		var colliding = collision_line(
			__h_side + _movement, 
			bbox_top, 
			__h_side + _movement, 
			bbox_bottom, 
			obj_collidable, 
			0, 
			1
		)
		
		if(colliding) break
		
		_movement += h_dir
		
		x += h_dir
	}
}