function array_index_of_value(array, value){
	static VALUE = undefined
	
	VALUE = value
	
	return array_find_index(
		array,
		function(_item) {
			return _item == array_index_of_value.VALUE
		}
	)

}