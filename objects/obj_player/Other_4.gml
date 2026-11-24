if(global.SEND_TO_CHECKPOINT && instance_exists(obj_checkpoint)) {
	x = obj_checkpoint.x
	y = obj_checkpoint.y
}

if(global.PLAYER_MARKER > -1) {
	var _marker = noone
	
	with(obj_player_location_marker) {
		if(global.PLAYER_MARKER == index) _marker = self
	}
	
	if(instance_exists(_marker)) {
		x = _marker.x
		y = _marker.y
	}
}
	
obj_camera.x = x
obj_camera.y = y
	
var _camera_wid = obj_camera._base_size * obj_camera.zoom_level,
	_camera_ht = _camera_wid * (1/obj_camera.aspect_ratio)
	
camera_set_view_pos(
	obj_camera.camera,
	clamp(x - _camera_wid / 2, 0, room_width - _camera_wid),
	clamp(y - _camera_ht / 2, 0, room_height - _camera_ht)
)

global.SEND_TO_CHECKPOINT = false
global.PLAYER_MARKER = -1