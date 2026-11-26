last_phase = array_length(boss_phase_items)

for (var i = 0; i < last_phase; ++i) {
    var _item_list = boss_phase_items[i]
	
	for (var j = 0; j < array_length(_item_list); ++j) {
	    instance_deactivate_object(_item_list[j])
	}
}

increment_phase()