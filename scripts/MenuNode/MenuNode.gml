enum MENU_NODE_TYPES {
	CUSTOM,
	ROW,
	COL,
	GRID,
	TEXT,
	BUTTON,
	INPUT,
	SPRITE,
	DROPDOWN,
	LIST
}

#macro has_bg bg_opa: 1, bg_col
#macro flex "flex(1)"
#macro vcenter valign: ALIGN.MIDDLE
#macro hcenter halign: ALIGN.CENTER
#macro allcenter valign: ALIGN.MIDDLE, halign: ALIGN.CENTER



/// @desc Function Creates a menu node
/// @param {enum.MENU_NODE_TYPES} type Type of the menu node
function MenuNode(type) constructor {
	self.type = type
	
	static predict_wid = function(parent, add_flex_callback) {
		return 0
	}
	
	static predict_ht = function(parent, add_flex_callback) {
		return 0
	}
	
	static refresh_size = function(Major, parent) {
		
	}
	
	static resize = function(Major, wid = undefined, ht = undefined, parent = undefined, from_refresh = false) {
	
	}
	
	static render = function(Major, parent) {
		
	}
	
	static unload = function() {
	
	}
}