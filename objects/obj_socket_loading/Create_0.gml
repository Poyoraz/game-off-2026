loading_set = []

is_loading = false
opacity = 0

add_to_loading_set = method(self, function(_item = "") {
	if(string_length(_item) == 0) return;
	
	if(!array_contains(
		loading_set,
		_item
	)) {
		array_push(loading_set, _item)
	}
})

remove_from_loading_set = method(self, function(_item) {
	if(array_length(loading_set) == 0) return;
	
	if(array_contains(
		loading_set,
		_item
	)) {
		array_delete(
			loading_set,
			array_index_of_value(loading_set, _item),
			1
		)
	}
})

clear_loading_set = method(self, function() {
	array_resize(loading_set, 0)
})
