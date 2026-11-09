list = ds_list_create()
hit_list = ds_list_create()

array_foreach(initial_items, function(item) {
	ds_list_add(hit_list, item)
})