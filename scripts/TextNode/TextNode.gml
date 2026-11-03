function TextNodeArgs() constructor {
	x = 0
	y = 0
	z = 0
	
	wid = 9999
	wrap_mode = wrapped_text.dots
	
	col = c_white
	opa = 1
	
	font = fnt_main
	
	bg_col = c_black
	bg_opa = 0
	
	on_update_before = undefined
	on_update_after = label_update_with_clickable
	on_draw_before = label_draw_with_scribble
	on_draw_after = undefined
	
	valign = ALIGN.TOP
	halign = ALIGN.LEFT
	
	emitter_event = "REGION_CLICK"
	
	use_ref = new UseRef()
}

/// @desc  Function Creates a text node
/// @param {string} text  Text to be displayed
/// @param {struct.textnodeargs} [props]=new TextNodeArgs() Description
function TextNode(
	text,
	props = new TextNodeArgs()
) : MenuNode(MENU_NODE_TYPES.TEXT) constructor {
	self.text = text
	
	#region PROPS
	static X_HASH = variable_get_hash("x")
	x = struct_get_existing_from_hash(props, X_HASH, 0)
	static Y_HASH = variable_get_hash("y")
	y = struct_get_existing_from_hash(props, Y_HASH, 0)
	static Z_HASH = variable_get_hash("z")
	z = struct_get_existing_from_hash(props, Z_HASH, 0)
	
	pos = new Vector3(x, y, z)
	
	static VALIGN_HASH = variable_get_hash("valign")
	valign = struct_get_existing_from_hash(props, VALIGN_HASH, ALIGN.TOP)
	static HALIGN_HASH = variable_get_hash("halign")
	halign = struct_get_existing_from_hash(props, HALIGN_HASH, ALIGN.LEFT)
	
	static WID_HASH = variable_get_hash("wid")
	wid = struct_get_existing_from_hash(props, WID_HASH, 9999)
	static WRAP_MODE_HASH = variable_get_hash("wrap_mode")
	wrapMode = struct_get_existing_from_hash(props, WRAP_MODE_HASH, wrapped_text.dots)
	
	static USE_REF_HASH = variable_get_hash("use_ref")
	use_ref = struct_get_existing_from_hash(props, USE_REF_HASH, new UseRef())
	
	static EMITTER_EVENT_HASH = variable_get_hash("emitter_event")
	emitter_event = struct_get_existing_from_hash(props, EMITTER_EVENT_HASH, "REGION_CLICK")
	
	static COL_HASH = variable_get_hash("col")
	_col = struct_get_existing_from_hash(props, COL_HASH, c_white)
	static OPACITY_HASH = variable_get_hash("opa")
	opa = struct_get_existing_from_hash(props, OPACITY_HASH, 1)
	
	col = new Vector4(
		color_get_red(_col),
		color_get_green(_col),
		color_get_blue(_col),
		opa * 255
	)
	
	static FONT_HASH = variable_get_hash("font")
	_font_asset = struct_get_existing_from_hash(props, FONT_HASH, fnt_main)
	font = font_get_name(_font_asset)
	
	static BG_COL_HASH = variable_get_hash("bg_col")
	_bg_col = struct_get_existing_from_hash(props, BG_COL_HASH, c_black)
	static BG_OPACITY_HASH = variable_get_hash("bg_opa")
	bg_opa = struct_get_existing_from_hash(props, BG_OPACITY_HASH, 0)
	
	bg_col = new Vector4(
		color_get_red(_bg_col),
		color_get_green(_bg_col),
		color_get_blue(_bg_col),
		bg_opa * 255
	)
	
	static UPDATE_BEFORE_HASH = variable_get_hash("on_update_before")
	on_update_before = struct_get_existing_from_hash(props, UPDATE_BEFORE_HASH)
	static UPDATE_AFTER_HASH = variable_get_hash("on_update_after")
	on_update_after = struct_get_existing_from_hash(props, UPDATE_AFTER_HASH, label_update_with_clickable)
	static DRAW_BEFORE_HASH = variable_get_hash("on_draw_before")
	on_draw_before = struct_get_existing_from_hash(props, DRAW_BEFORE_HASH, label_draw_with_scribble)
	static DRAW_AFTER_HASH = variable_get_hash("on_draw_after")
	on_draw_after = struct_get_existing_from_hash(props, DRAW_AFTER_HASH)
	
	static predict_wid = function(parent, add_flex_callback) {
		var _wid = resolve_size(wid, parent)
		
		if(_wid < 9999) return _wid 
		
		draw_set_font(_font_asset)
		return string_width_scribble_ext(
			text,
			_wid 
		)
	}
	
	static predict_ht = function(parent, add_flex_callback) {
		var _wid = resolve_size(wid, parent)
		
		draw_set_font(_font_asset)
		return string_height_scribble_ext(
			text,
			_wid 
		)
	}
	
	static render = function(Major, parent = noone) {
		var _wid = resolve_size(wid, parent)
		
		var label = Major.LabelCreate(
			pos,
			text,
			parent,
			_wid,
			wrapMode,
			col,
			noone,
			bg_col, 
			on_update_before, 
			on_update_after, 
			on_draw_before, 
			on_draw_after
		)
		
		label[? "fontName"] = font
		label[? "textAlignment"] = new Align(halign, valign)
		
		TextSetEmitterEvent(label, emitter_event)
		
		build_scribble_item(label)
		
		use_ref.setup(label)
		
		return label
	}
}