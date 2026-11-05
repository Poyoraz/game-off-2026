grappled = noone

list = ds_list_create()

horizontal_speed = lengthdir_x(speed, direction)
vertical_speed = lengthdir_y(speed, direction)

speed = 0

stop_speed = function(contacted) {
	if(contacted.object_index == obj_player) return false;

	grappled = contacted
	horizontal_speed = 0
	vertical_speed = 0
	
	return true
}