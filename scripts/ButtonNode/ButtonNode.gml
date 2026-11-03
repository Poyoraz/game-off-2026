function ButtonNodeArgs() constructor {
	x = 0
	y = 0
	z = 0
	
	wid = 256
	ht = 64

	on_click = noone
	
	use_ref = new UseRef()
	
	on_update_before = undefined
	on_update_after = undefined
	on_draw_before = undefined
	on_draw_after = button_draw_with_scribble
	
	bg_col = c_red
	bg_opa = 1
}

/// @desc  Function Creates a button node
/// @param {string} text Content of the button
/// @param {struct.ButtonNodeArgs} props Properties
function ButtonNode(
	text = "Click",
	props = new ButtonNodeArgs()
) : MenuNode(MENU_NODE_TYPES.BUTTON) constructor {
	self.text = text
	
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
	ht = struct_get_existing_from_hash(props, HT_HASH, 64)
	
	static BG_COL_HASH = variable_get_hash("bg_col")
	_bg_col = struct_get_existing_from_hash(props, BG_COL_HASH, c_dkgray)
	static BG_OPACITY_HASH = variable_get_hash("bg_opa")
	bg_opa = struct_get_existing_from_hash(props, BG_OPACITY_HASH, 1)
	
	bg_col = new Vector4(
		color_get_red(_bg_col),
		color_get_green(_bg_col),
		color_get_blue(_bg_col),
		bg_opa * 255
	)
	
	static ON_CLICK_HASH = variable_get_hash("on_click")
	_inner_on_click = struct_get_existing_from_hash(props, ON_CLICK_HASH, noone)
	
	on_click = get_on_click_with_loading()
	
	static USE_REF_HASH = variable_get_hash("use_ref")
	use_ref = struct_get_existing_from_hash(props, USE_REF_HASH, new UseRef())
	
	static UPDATE_BEFORE_HASH = variable_get_hash("on_update_before")
	on_update_before = struct_get_existing_from_hash(props, UPDATE_BEFORE_HASH)
	static UPDATE_AFTER_HASH = variable_get_hash("on_update_after")
	on_update_after = struct_get_existing_from_hash(props, UPDATE_AFTER_HASH)
	static DRAW_BEFORE_HASH = variable_get_hash("on_draw_before")
	on_draw_before = struct_get_existing_from_hash(props, DRAW_BEFORE_HASH)
	static DRAW_AFTER_HASH = variable_get_hash("on_draw_after")
	on_draw_after = struct_get_existing_from_hash(props, DRAW_AFTER_HASH, button_draw_with_scribble)
	
	static predict_wid = _predict_wid
	
	static predict_ht = _predict_ht
	
	static render = function(Major, parent = noone) {
		var size = new Vector2(
			resolve_size(wid, parent),
			resolve_size(ht, parent, true)
		)
		
		var button = Major.ButtonCreate(
			pos,
			text,
			parent,
			on_click,
			size,
			on_update_before, 
			on_update_after, 
			on_draw_before, 
			on_draw_after
		)
		
		button[? "idleCol"] = bg_col
		
		use_ref.setup(button)
		
		return button
	}
}

function button_draw_with_scribble(fm_button) {
	scribble($"[fnt_main]{ButtonGetText(fm_button)}")
		.align(fa_middle, fa_center)
		.draw(CanvasGetSize(fm_button).x / 2, CanvasGetSize(fm_button).y / 2)
}