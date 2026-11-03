/// @desc Function Description
/// @param {string} event Description
/// @param {Function} callback Description
function scr_add_listener(event, callback){
	if(!ds_map_exists(global.listeners, event)) global.listeners[? event] = []
	
	var _arr = global.listeners[? event]
	
	array_push(
		_arr,
		new Listener(callback)
	)

	return {
		event,
		pos: array_length(_arr) - 1
	}
}