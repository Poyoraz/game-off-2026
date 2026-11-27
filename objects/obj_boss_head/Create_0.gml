event_inherited()

boss_phase_items = []

current_phase = -1
last_phase = 0

charge_sounds = [snd_13_5_resample, snd_6_5_resample, snd_3_7_rsample]

shockwave_timer = 1200

part_sys = part_system_create_layer(layer, false)
p_absorb = particle_get_info(prs_boss_charge).emitters[0].parttype.ind

shockwave_radius = 0
	
laser_direction = 0

shockwave_list = ds_list_create()

phase_break = false

increment_phase = method(self, function() {
	instance_destroy(obj_bullet)
	
	var _current_phase_items = boss_phase_items[current_phase],
		_current_phase_item_count = array_length(_current_phase_items)
	
	for (var i = 0; i < _current_phase_item_count; ++i) {
		var _item = _current_phase_items[i]
		
		if(!instance_exists(_item)) continue
		
		instance_destroy(_item)
	}
		
	run_headless_animation(
		new LinearCombinedAnimation([
			boss_impact_frame(120),
			new RunFunctionAnimation(start_new_phase)
		]),
		x,
		y,
		depth -1
	)
})

start_new_phase = method(self, function() {
	array_foreach(
		charge_sounds,
		scr_stop_sound
	)
	
	current_phase++
	
	if(last_phase == current_phase) {
			
		return
	}
	
	var _next_phase_items = boss_phase_items[current_phase],
		_next_phase_item_count = array_length(_next_phase_items)
	
	obj_player.warp(room_width / 2, room_height / 2, true)
	
	for (var i = 0; i < _next_phase_item_count; ++i) {
	    var _item = _next_phase_items[i]
		
		instance_activate_object(_item)
	}
	
	shockwave_timer = 1200
	shockwave_radius = 0
			
	ds_list_clear(shockwave_list)
	
	if(instance_exists(obj_player_location_marker)) {
		var _marker = instance_find(obj_player_location_marker, 0)
		
		obj_player.warp(
			_marker.x, 
			_marker.y, 
			true
		)
	} else {
		obj_player.warp(room_width / 2, room_height / 2, true)
	}

})