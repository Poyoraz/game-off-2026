function ListNodeArgs() constructor {
	vertical = false
	has_scroll = false
	
	render_item = default_render_item
}

/// @desc
/// @param {struct.UseRef} controller_ref
/// @param {struct.ListNodeArgs} props
/// @param {struct.ColNodeArgs,struct.RowNodeArgs} inner_props
function ListNode(
	controller_ref,
	props = new ListNodeArgs(),
	inner_props = new ColNodeArgs()
) : MenuNode(MENU_NODE_TYPES.LIST) constructor {
	
	#region PROPS
	static VERTICAL_HASH = variable_get_hash("vertical")
	vertical = struct_get_existing_from_hash(props, VERTICAL_HASH, false)
	
	RootItem = vertical ? RowNode : ColNode
	
	static HAS_SCROLL_HASH = variable_get_hash("has_scroll")
	has_scroll = struct_get_existing_from_hash(props, HAS_SCROLL_HASH, false)
	
	static RENDER_ITEM_HASH = variable_get_hash("render_item")
	render_item = struct_get_existing_from_hash(props, RENDER_ITEM_HASH, default_render_item)
	#endregion
	
	#region REFS
	
	if(!struct_get(inner_props, "use_ref")) {
		inner_props = struct_copy(inner_props)
		inner_props.use_ref = new UseRef()	
	}
	
	root_ref = inner_props.use_ref

	use_ref = controller_ref
	
	#endregion
	
	#region ACTIONS
	
	children = []
	static set_data = function(data) {
		root.clear_children()
		
		children = data
		
		root.children = array_map(data, render_item)
		
		CanvasSetQueueUpdate(root_ref.current, true)
	}
	
	#endregion
	
	#region INHERITED ACTIONS
	static predict_wid = function(parent, add_flex_callback) {
		return root.predict_wid(parent, add_flex_callback)
	}
	
	static predict_ht = function(parent, add_flex_callback) {
		return root.predict_ht(parent, add_flex_callback)
	}
	
	static refresh_size = function(Major, parent) {
		return root.refresh_size(Major, parent)	
	}
	
	static resize = function(Major, wid = undefined, ht = undefined, parent = undefined, from_refresh = false) {
		return root.resize(Major, wid, ht, parent, from_refresh)
	}
	#endregion
	
	root = new RootItem(
		[
		],
		inner_props
	)
	
	static render = function(Major, parent) {
		var item = method(root, root.render)(Major, parent)
		
		use_ref.setup(self)
		
		return item
	}

}

function default_render_item(item, index) {
	return new TextNode(item)
}