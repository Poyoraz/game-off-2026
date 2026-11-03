/// @function								struct_get_existing_from_hash(_struct, _name, _default)
/// @description							Takes a struct and tries to get a value with a name from it, if it doesn't exist, returns another value
/// @param {Struct}							_struct		The struct to be searched
/// @param {Real}							_hash		The hash of the variable
/// @param {Any}							[_default]	The default value, defaults to undefined
/// @return {Any}
/// @pure
function struct_get_existing_from_hash(_struct, _hash, _default = undefined){
	if(!struct_exists_from_hash(_struct, _hash)) return _default
	
	return struct_get_from_hash(_struct, _hash)
}