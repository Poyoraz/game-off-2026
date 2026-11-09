function ds_list_to_array(list){
	var _size = ds_list_size(list)
	
	var _arr = array_create(_size)
	
	for (var i = 0; i < _size; ++i) {
		_arr[i] = list[| i]
	}
	
	return _arr
}