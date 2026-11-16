if(global.SEND_TO_CHECKPOINT && instance_exists(obj_checkpoint)) {
	x = obj_checkpoint.x
	y = obj_checkpoint.y
	
	obj_camera.x = x
	obj_camera.y = y
}

global.SEND_TO_CHECKPOINT = false