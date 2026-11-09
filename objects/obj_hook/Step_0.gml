var _dist = point_distance(x, y, obj_player.x, obj_player.y)

if(_dist > 1200) {
	instance_destroy()
}

var _vsp = vertical_speed
var v_dir = sign(_vsp)

if(v_dir != 0) {
	var __v_side = (v_dir == 1 ? bbox_bottom : bbox_top) + v_dir
	
	var _movement = 0
	
	repeat (abs(_vsp)) {	
		var colliding = collision_line(
			bbox_left + 1, 
			__v_side + _movement, 
			bbox_right - 1, 
			__v_side + _movement, 
			obj_collidable, 0, 1
		)
		
		if(instance_exists(colliding)) {
			if(stop_speed(colliding)) break
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
	
	repeat (abs(_hsp)) {	
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
			if(stop_speed(colliding)) break
		}
		
		_movement += h_dir
		
		x += h_dir
	}
}