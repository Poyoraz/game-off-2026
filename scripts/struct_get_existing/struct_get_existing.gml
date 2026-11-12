/// @function								struct_get_existing(_struct, _name, _default)
/// @description							Takes a struct and tries to get a value with a name from it, if it doesn't exist, returns another value
/// @param {Struct}							_struct		The struct to be searched
/// @param {String}							_name		The name of the variable
/// @param {Any}							[_default]	The default value, defaults to undefined
/// @return {Any}
/// @pure
function struct_get_existing(_struct, _name, _default = undefined){
	if(!is_struct(_struct)) return _default
	if(!variable_struct_exists(_struct, _name)) return _default
	
	return variable_struct_get(_struct, _name)
}

