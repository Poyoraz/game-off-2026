var _camera = obj_camera.camera

var _x1 = camera_get_view_x(_camera),
	_y1 = camera_get_view_y(_camera),
	_x2 = _x1 + camera_get_view_width(_camera),
	_y2 = _y1 + camera_get_view_height(_camera)	
	
if(point_in_rectangle(
	x,
	y,
	_x1,
	_y1,
	_x2,
	_y2
)) {
	if(!entered) {
		on_enter(self)
		entered = true
	}
	
} else {
	if(entered) {
		entered = false
	}
}