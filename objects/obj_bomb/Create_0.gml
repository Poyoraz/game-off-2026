// Inherit the parent event
event_inherited();

on_collide = method(self, function(collidee) {
	var _list = ds_list_create()
	
	collidee.transmit_momentum(300, false, TransmitMomentumType.COLLISION)
	collidee.transmit_momentum(300, true, TransmitMomentumType.COLLISION)
	
	var _count = collision_circle_list(x, y, 120, obj_terrain, false, true, _list, false)
	
	for (var i = 0; i < _count; ++i) {
	    var _item = _list[| i]
		
		if(_item.explosion_resistant) continue
		
		instance_destroy(_item)
	}
	
	ds_list_destroy(_list)
	
	instance_destroy()
	
	scr_play_sound(snd_meaty_explosion)
	
	if(collidee == obj_boss_head.id) {
		obj_boss_head.increment_phase()
	} else {
		run_headless_animation(
			screen_shake(10),
			x,
			y,
			0
		)
	}
})