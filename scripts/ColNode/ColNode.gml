function ColNodeArgs() constructor {
	x = 0
	y = 0
	z = 0
	
	h_gap = 0
	v_gap = 0
	
	auto_fit = false
	
	wid = "auto"
	ht = "auto"

	on_click = noone
	
	bg_col = c_black
	bg_opa = 0
	
	on_update_before = undefined
	on_update_after = CanvasUpdatePanelWithHover
	on_draw_before = undefined
	on_draw_after = undefined
	
	on_update_before_title = undefined
	on_update_after_title = undefined
	on_draw_before_title = undefined
	on_draw_after_title = undefined
	
	on_enter = undefined
	on_leave = undefined
	
	valign = ALIGN.TOP
	halign = ALIGN.LEFT
	
	has_scroll_y = false
}

/// @desc  Function Creates a col node
/// @param {Array<MenuNode>} children Content of the col
/// @param {struct.ColNodeArgs} props Properties
function ColNode(
	children = [],
	props = new ColNodeArgs()
) : MenuNode(MENU_NODE_TYPES.COL) constructor {
	self.children = children
	
	#region PROPS
	static X_HASH = variable_get_hash("x")
	x = struct_get_existing_from_hash(props, X_HASH, 0)
	static Y_HASH = variable_get_hash("y")
	y = struct_get_existing_from_hash(props, Y_HASH, 0)
	static Z_HASH = variable_get_hash("z")
	z = struct_get_existing_from_hash(props, Z_HASH, 0)
	
	pos = new Vector3(x, y, z)
	
	static V_GAP_HASH = variable_get_hash("v_gap")
	v_gap = struct_get_existing_from_hash(props, V_GAP_HASH, 0)
	static H_GAP_HASH = variable_get_hash("h_gap")
	h_gap = struct_get_existing_from_hash(props, H_GAP_HASH, 0)
	
	gap = new Vector2(h_gap, v_gap)
	
	static AUTO_FIT_HASH = variable_get_hash("auto_fit")
	auto_fit = struct_get_existing_from_hash(props, AUTO_FIT_HASH, false)
	
	static WID_HASH = variable_get_hash("wid")
	wid = struct_get_existing_from_hash(props, WID_HASH, "auto")
	static HT_HASH = variable_get_hash("ht")
	ht = struct_get_existing_from_hash(props, HT_HASH, "auto")
	
	static VALIGN_HASH = variable_get_hash("valign")
	valign = struct_get_existing_from_hash(props, VALIGN_HASH, ALIGN.TOP)
	static HALIGN_HASH = variable_get_hash("halign")
	halign = struct_get_existing_from_hash(props, HALIGN_HASH, ALIGN.LEFT)
	
	align = new Align(halign, valign)
	
	static ON_CLICK_HASH = variable_get_hash("on_click")
	on_click = struct_get_existing_from_hash(props, ON_CLICK_HASH, noone)
	
	static USE_REF_HASH = variable_get_hash("use_ref")
	use_ref = struct_get_existing_from_hash(props, USE_REF_HASH, new UseRef())
	
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
	
	static HAS_SCROLL_Y_HASH = variable_get_hash("has_scroll_y")
	has_scroll_y = struct_get_existing_from_hash(props, HAS_SCROLL_Y_HASH, false)
	
	static UPDATE_BEFORE_HASH = variable_get_hash("on_update_before")
	on_update_before = struct_get_existing_from_hash(props, UPDATE_BEFORE_HASH)
	static UPDATE_AFTER_HASH = variable_get_hash("on_update_after")
	on_update_after = struct_get_existing_from_hash(props, UPDATE_AFTER_HASH, CanvasUpdatePanelWithHover)
	static DRAW_BEFORE_HASH = variable_get_hash("on_draw_before")
	on_draw_before = struct_get_existing_from_hash(props, DRAW_BEFORE_HASH)
	static DRAW_AFTER_HASH = variable_get_hash("on_draw_after")
	on_draw_after = struct_get_existing_from_hash(props, DRAW_AFTER_HASH)
	
	static UPDATE_BEFORE_HASH_TITLE = variable_get_hash("on_update_before_title")
	on_update_before_title = struct_get_existing_from_hash(props, UPDATE_BEFORE_HASH_TITLE)
	static UPDATE_AFTER_HASH_TITLE = variable_get_hash("on_update_after_title")
	on_update_after_title = struct_get_existing_from_hash(props, UPDATE_AFTER_HASH_TITLE)
	static DRAW_BEFORE_HASH_TITLE = variable_get_hash("on_draw_before_title")
	on_draw_before_title = struct_get_existing_from_hash(props, DRAW_BEFORE_HASH_TITLE)
	static DRAW_AFTER_HASH_TITLE = variable_get_hash("on_draw_after_title")
	on_draw_after_title = struct_get_existing_from_hash(props, DRAW_AFTER_HASH_TITLE)
	
	static ON_ENTER_HASH = variable_get_hash("on_enter")
	on_enter = struct_get_existing_from_hash(props, ON_ENTER_HASH)
	static ON_LEAVE_HASH = variable_get_hash("on_leave")
	on_leave = struct_get_existing_from_hash(props, ON_LEAVE_HASH)
	#endregion
	
	#region INHERITED ACTIONS
	static predict_wid = _predict_wid
	
	static predict_ht = _predict_ht
	
	static refresh_size = _refresh_size
	
	static resize = function(Major, wid = undefined, ht = undefined, parent = undefined, from_refresh = false) {
		var size_changed = _resize(Major, wid, ht, parent, from_refresh)
		
		if(!size_changed) return;
		
		var panel = use_ref.current
		
		calculate_flex_units(Major)
		
		var _len = array_length(children)
		for(var i = 0; i < _len; i++) {
			var child = children[i]
			
			child.refresh_size(Major, use_ref.current)
		}
		
		//Major.PanelRefresh(panel)
	}
	#endregion
	
	#region FLEX MANAGEMENT	
	static calculate_flex_units = function(Major) {
		var panel = use_ref.current
		
		var size = Major.CanvasGetSize(panel)
		
		var flexable = {
				wid: size.x,
				ht: size.y
			},
			total_flex = {
				h: 0,
				v: 0
			},
			_len = array_length(children)
			
		var increase_v_flex = method(total_flex, function(_val) {
				v += _val
			}),
			increase_h_flex = method(total_flex, function(_val) {
				h += _val
			})
		
		// CALCULATE FLEXIBLE AREA
		flexable.ht -= gap.y
		for(var i = 0; i < _len; i++) {
			var child = children[i]
			
			flexable.ht -= child.predict_ht(panel, increase_h_flex)
		
			flexable.ht -= gap.y
		}
		
		flexable.wid -= gap.x * 2
		
		CanvasSetFlexUnits(
			panel,
			flexable.ht / total_flex.h,
			true
		)
		
		CanvasSetFlexUnits(
			panel,
			flexable.wid,
			false
		)
	}
	#endregion
	
	#region CHILDREN MANAGEMENT
	children_elements = []
	
	static update_children = function() {
		var panel = use_ref.current
		
		calculate_flex_units(obj_menu.Major)
		
		var _len = array_length(children)
		
		for(var i = 0; i < _len; i++) {
			var child = children[i]
			
			child.refresh_size(obj_menu.Major, panel)
		}
		
		obj_menu.Major.PanelRefresh(panel)
	}
	
	static clear_children = function() {
		CanvasSetQueueClear(use_ref.current, true)
		
		children = []
		children_elements = []
	}
	
	static render_children = function() {
		var panel = use_ref.current,
			Major = obj_menu.Major
		
		var _len = array_length(children)
		
		for(var i = 0; i < _len; i++) {
			var child = children[i]
			
			Major.PanelPush(panel, "", 1, true)
			
			array_push(
				children_elements,
				Major.PanelElementCreate(
					panel,
					(child.render(Major, panel)),
					1,
					false,
					align
				)
			)
			
			Major.PanelPop(panel)
		}
		
		if(has_scroll_y) {
			var total_ht = 0
			
			var elems = panel[? "elements"]
			
			var _elem_size = ds_list_size(elems)

			for (var i = 0; i < _elem_size; ++i) {
			    total_ht += elems[| i][? "size"].y + (panel[? "v_gap"] ?? 0)
			}
			
			show_debug_message(total_ht)
			
			ElementSetProperty(panel, max(4000, total_ht * 36), "m_scrollbarVerticalSteps")
		}
	}
	#endregion
	
	static render = function(Major, parent = noone) {
		var size = new Vector2(
			resolve_size(wid, parent),
			resolve_size(ht, parent, true)
		)
		
		var panel = Major.PanelCreate(
			pos,
			gap,
			auto_fit,
			parent,
			bg_col,
			size,
			on_click,
			on_update_before, 
			on_update_after, 
			on_draw_before, 
			on_draw_after,
			on_update_before_title, 
			on_update_after_title, 
			on_draw_before_title,
			on_draw_after_title
		)
		
		CanvasSetUpdateChildren(panel, method(self, update_children))
		CanvasSetRenderChildren(panel, method(self, render_children))
		
		CanvasSetHovering(panel, false)
		
		CanvasSetEnterEvent(panel, on_enter)
		CanvasSetLeaveEvent(panel, on_leave)
		
		use_ref.setup(panel)
		
		calculate_flex_units(Major)
		
		render_children()
		
		if(has_scroll_y) {
			var _CreateHandler = Major.ScrollbarVerticalCreate
			
			var scrollbar_width = 3,
				scrollbar_right_gap = 5
			
			var scrollbar = _CreateHandler(
				new Vector3(
					size.x * 2, 
					3, 
					100
				), 
				panel, 
				new Vector2(scrollbar_width, size.y - 3 * 2), 
				parent
			)
			
			ElementSetProperty(panel, scrollbar, "m_scrollbarVertical")
		}
		
		return panel
		
	}
}