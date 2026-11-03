function InputNodeArgs() constructor {
	x = 0
	y = 0
	z = 0
	
	wid = 256
	ht = 28

	placeholder = "Enter Text..."
	
	multiline = false
	
	password = false
}

/// @desc  Function Creates a input node
/// @param {Function} refCallback a function that the textbox will be passed through when the function is called
/// @param {struct.InputNodeArgs} props Properties
function InputNode(
	ref_callback = function(_item) {},
	props = new InputNodeArgs()
) : MenuNode(MENU_NODE_TYPES.INPUT) constructor {
	self.ref_callback = ref_callback
	
	static X_HASH = variable_get_hash("x")
	x = struct_get_existing_from_hash(props, X_HASH, 0)
	static Y_HASH = variable_get_hash("y")
	y = struct_get_existing_from_hash(props, Y_HASH, 0)
	static Z_HASH = variable_get_hash("z")
	z = struct_get_existing_from_hash(props, Z_HASH, 0)
	
	pos = new Vector3(x, y, z)
	
	static AUTO_FIT_HASH = variable_get_hash("auto_fit")
	auto_fit = struct_get_existing_from_hash(props, AUTO_FIT_HASH, false)
	
	static WID_HASH = variable_get_hash("wid")
	wid = struct_get_existing_from_hash(props, WID_HASH, 256)
	static HT_HASH = variable_get_hash("ht")
	ht = struct_get_existing_from_hash(props, HT_HASH, 28)
	
	static PLACEHOLDER_HASH = variable_get_hash("placeholder")
	placeholder = struct_get_existing_from_hash(props, PLACEHOLDER_HASH, "Enter Text...")

	static MULTILINE_HASH = variable_get_hash("multiline")
	multiline = struct_get_existing_from_hash(props, MULTILINE_HASH, false)
	
	static PASSWORD_HASH = variable_get_hash("password")
	password = struct_get_existing_from_hash(props, PASSWORD_HASH, false)
	
	static predict_wid = _predict_wid
	
	static predict_ht = _predict_ht
	
	static refresh_size = _refresh_size
	
	static resize = _resize
	
	static render = function(Major, parent = noone) {
		var size = new Vector2(
			resolve_size(wid, parent),
			resolve_size(ht, parent, true)
		)
		
		var textbox = Major.TextboxCreate(
			pos,
			size,
			parent
		)
		
		Major.TextboxSetGhostText(textbox, placeholder)
		
		Major.TextboxSetPassword(textbox, password)
		
		Major.TextboxSetMultiline(textbox, multiline)
		
		ref_callback.setup(textbox)
		
		return textbox	
	}
}