/// @desc Function Description
/// @param {string} event Description
function scr_listener_exists(event){
	if(!ds_map_exists(global.listeners, event)) return false
	
	return array_any(global.listeners[? event], function(item) {
		return !is_undefined(item)
	})
}