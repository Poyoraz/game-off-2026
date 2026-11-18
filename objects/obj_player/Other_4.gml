if(global.SEND_TO_CHECKPOINT && instance_exists(obj_checkpoint)) {
	x = obj_checkpoint.x
	y = obj_checkpoint.y
	
	obj_camera.x = x
	obj_camera.y = y
	
	var _camera_wid = obj_camera._base_size * obj_camera.zoom_level,
		_camera_ht = _camera_wid * (1/obj_camera.aspect_ratio)
	
	camera_set_view_pos(
		obj_camera.camera,
		clamp(x, _camera_wid / 2, room_width - _camera_wid/2),
		clamp(y, _camera_ht / 2, room_height - _camera_wid/2)
	)
}

global.SEND_TO_CHECKPOINT = false