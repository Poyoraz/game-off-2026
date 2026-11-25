ds_list_clear(list)

instance_place_list(x, y, obj_physics_item, list, false)

var _count = ds_list_size(list)

var _hit_movable_item = false

for (var i = 0; i < _count; ++i) {
	var _item = list[| i]
	
	if(!_item.lock_vertical) {
		_hit_movable_item = true
	}
	
    if(ds_list_find_index(hit_list, _item) != -1) continue
	
	ds_list_add(hit_list, _item)
	
	scr_play_sound(player_caused
		? choose(snd_p_shockwave_1, snd_p_shockwave_2, snd_p_shockwave_3, snd_p_shockwave_4, snd_p_shockwave_5, snd_p_shockwave_6, snd_p_shockwave_7, snd_p_shockwave_8, snd_p_shockwave_9, snd_p_shockwave_10)
		: choose(snd_e_shockwave_1, snd_e_shockwave_2, snd_e_shockwave_3, snd_e_shockwave_4, snd_e_shockwave_5, snd_e_shockwave_6, snd_e_shockwave_7, snd_e_shockwave_8, snd_e_shockwave_9, snd_e_shockwave_10)
	)
	_item.transmit_momentum(-size, true, TransmitMomentumType.SHOCKWAVE)
}

if(!_hit_movable_item) {
	if(--lifetime < 0) instance_destroy()
}