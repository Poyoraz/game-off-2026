event_inherited()

boss_phase_items = []

current_phase = -1

increment_phase = method(self, function() {
	if(current_phase > -1) {
		var _current_phase_items = boss_phase_items[current_phase],
			_current_phase_item_count = array_length(_current_phase_items)
	
		for (var i = 0; i < _current_phase_item_count; ++i) {
		    var _item = _current_phase_items[i]
		
			if(!instance_exists(_item)) continue
		
			instance_destroy(_item)
		}
	
		obj_player.warp(room_width / 2, room_height / 2, true)
	}
	current_phase++
	
	var _next_phase_items = boss_phase_items[current_phase],
		_next_phase_item_count = array_length(_next_phase_items)
	
	obj_player.warp(room_width / 2, room_height / 2, true)
	
	for (var i = 0; i < _next_phase_item_count; ++i) {
	    var _item = _next_phase_items[i]
		
		instance_activate_object(_item)
	}
})