/// @desc Function Takes a value, a parent and returns a number by calculating it similar to HTML
/// @param {string,real} value A numeric value or instructions, currently includes reverse, sub, flex and %
/// @param {id.dsmap} parent The Parent item, must include size
/// @param {bool} [is_height]=false Is the value being calculated height
/// @returns {number}
function resolve_size(value, parent, is_height = false){
	if(is_numeric(value)) return value
	
	static Major = new MajorGUI()
	
	var parent_vector = Major.CanvasGetSize(parent)
	
	if(string_starts_with(value, "reverse(")) {
		var cleared = string_copy(value, 9, string_length(value) - 9)
		
		return resolve_size(cleared, parent, !is_height)
	}

	if(string_starts_with(value, "sub(")) {
		var cleared = string_copy(value, 5, string_length(value) - 5),
			split = string_split(cleared, ","),
			split_count = array_length(split)
			
		var final_val = resolve_size(split[0], parent, is_height)
		
		for(var _i = 1; _i < split_count; _i++) {
			final_val -= resolve_size(split[_i], parent, is_height)
		}
		
		return final_val
	}

	if(string_starts_with(value, "flex(")) {
		
		var cleared = real(string_copy(value, 6, string_length(value) - 6))
		
		var flex_unit = CanvasGetFlexUnits(parent, is_height)
		
		return flex_unit * cleared
	}
	
	if(value == "auto") {
		return is_height ? parent_vector.y : parent_vector.x
	}
	
	if(string_ends_with(value, "%")) {
		var perc = real(string_digits(value))
		
		return (is_height ? parent_vector.y : parent_vector.x) * perc / 100
	}
	
	return real(string_digits(value))
}