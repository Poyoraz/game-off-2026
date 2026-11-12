function SaveFile(data = {}) constructor{
	
	highest_act = struct_get_existing(data, "highest_act", 0)
	
	var _level_name = struct_get_existing(data, "current_level", room_get_name(room_ground_test))
	current_level = asset_get_index(_level_name)
	if(current_level == -1) current_level = room_ground_test 
	
	flags = struct_get_existing(data, "flags", [])
	
	static activate_checkpoint = function() {
		current_level = room
	}
	
	static has_flag = function(flag_name) {
		return array_contains(flags, flag_name)
	}
	
	static add_flag = function(flag_name) {
		return array_push(flags, flag_name)
	}
	
	static remove_flag = function(flag_name) {
		array_delete(
			flags,
			array_index_of_value(flags, flag_name),
			1
		)
	}
	
	static clear_flags = function() {
		var _old_flags = flags
		
		flags = []
		
		return _old_flags
	}
	
	static export_save = function() {
		return {
			highest_act,
			flags,
			current_level: room_get_name(current_level)
		}
	}
}