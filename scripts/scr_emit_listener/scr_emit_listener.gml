function scr_emit_listener(event, data){
	if(!ds_map_exists(global.listeners, event)) return;
	
	var _arr = global.listeners[? event],
		_arr_len = array_length(_arr)
		
	for(var _i = 0; _i < _arr_len; _i++) {
		var _item = _arr[_i]
		
		if(is_undefined(_item)) continue
		
		_item.callback(data)
	}
}