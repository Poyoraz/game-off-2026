function DropdownNodeArgs() constructor {
	x = 0
	y = 0
	z = 0
	
	wid = 256
	ht = 28

	placeholder = "Select an option"
	
	preselect = -1
}

/// @desc  Function Creates a dropdown node
/// @param {Array<string>} options a function that the textbox will be passed through when the function is called
/// @param {Function} refCallback a function that the textbox will be passed through when the function is called
/// @param {struct.DropdownNodeArgs} props Properties
function DropdownNode(
	options = [],
	ref_callback = function(_item) {},
	props = new DropdownNodeArgs()
) : MenuNode(MENU_NODE_TYPES.DROPDOWN) constructor {
	self.ref_callback = ref_callback
	self.options = options
	
	static X_HASH = variable_get_hash("x")
	x = struct_get_existing_from_hash(props, X_HASH, 0)
	static Y_HASH = variable_get_hash("y")
	y = struct_get_existing_from_hash(props, Y_HASH, 0)
	static Z_HASH = variable_get_hash("z")
	z = struct_get_existing_from_hash(props, Z_HASH, 0)
	
	pos = new Vector3(x, y, z)
	
	static WID_HASH = variable_get_hash("wid")
	wid = struct_get_existing_from_hash(props, WID_HASH, 256)
	static HT_HASH = variable_get_hash("ht")
	ht = struct_get_existing_from_hash(props, HT_HASH, 28)
	
	static PLACEHOLDER_HASH = variable_get_hash("placeholder")
	placeholder = struct_get_existing_from_hash(props, PLACEHOLDER_HASH, "Select an option")
	
	static PRESELECT_HASH = variable_get_hash("preselect")
	preselect = struct_get_existing_from_hash(props, PRESELECT_HASH, -1)
	
	static predict_wid = _predict_wid
	
	static predict_ht = _predict_ht
	
	static refresh_size = _refresh_size
	
	static resize = _resize
	
	static render = function(Major, parent = noone) {
		var size = new Vector2(
			resolve_size(wid, parent),
			resolve_size(ht, parent, true)
		)
		
		var combobox = Major.ComboboxCreate(
			pos,
			placeholder,
			parent,
			size,
		)
		
		for(var _i = 0; _i < array_length(options); _i++ ) {
			var _item = options[_i]
			
			var _selectable = Major.ComboboxPush(combobox, _item)
			
			if(_i == preselect) Major.ComboboxSelect(combobox, _selectable)
		}
		
		ref_callback.setup(combobox)
		
		return combobox
	}
}

function DropdownGetCurrent(dropdown_ref) {
	return ElementGetProperty(
		ElementGetProperty(dropdown_ref, "selected"),
		"name"
	)
}