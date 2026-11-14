function array_easy_copy(array){
	var _arr = []
	
	array_copy(_arr, 0, array, 0, array_length(array))
	
	return _arr
}