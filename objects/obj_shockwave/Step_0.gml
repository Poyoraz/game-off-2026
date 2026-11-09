ds_list_clear(list)

instance_place_list(x, y, obj_physics_item, list, false)

var _count = ds_list_size(list)

if(_count == 0) {
	instance_destroy()	
}

for (var i = 0; i < _count; ++i) {
	var _item = list[| i]
	
	show_debug_message([_item, ds_list_find_index(hit_list, _item)])
    if(ds_list_find_index(hit_list, _item) != -1) continue
	
	ds_list_add(hit_list, _item)
	
	_item.transmit_momentum(-size, true, TransmitMomentumType.SHOCKWAVE)
}