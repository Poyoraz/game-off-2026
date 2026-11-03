function scr_remove_listener(_signature){
	var event = _signature.event,
		pos = _signature.pos
	
	if(!ds_map_exists(global.listeners, event)) return;
	if(pos < 0) return;
	
	global.listeners[? event][pos] = undefined
}