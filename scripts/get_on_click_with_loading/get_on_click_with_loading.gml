function get_on_click_with_loading(){
	if(_inner_on_click == noone) return noone
	
	return method(self, function(_item) {
		if(instance_exists(obj_socket_loading)) {
			if(obj_socket_loading.is_loading) return
		}
			
		_inner_on_click(_item)
	})
}