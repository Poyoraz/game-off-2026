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
	
	_item.transmit_momentum(-size, true, TransmitMomentumType.SHOCKWAVE)
}

if(!_hit_movable_item) {
	if(--lifetime < 0) instance_destroy()
}