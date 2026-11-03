function _predict_wid(parent, add_flex_callback) {
	if(string_starts_with(wid, "flex(")) {
		
		var cleared = string_copy(wid, 6, string_length(wid) - 6)
		
		add_flex_callback(real(string_digits(cleared)))
		return 0
	}
		
	return resolve_size(wid, parent)
}

function _predict_ht(parent, add_flex_callback) {
	if(string_starts_with(ht, "flex(")) {
		
		var cleared = string_copy(ht, 6, string_length(ht) - 6)
		
		add_flex_callback(real(string_digits(cleared)))
		return 0
	}
		
	return resolve_size(ht, parent, true)
}

/**
 * @desc Basic resize functionality, requires the object calling to have use_ref, wid and ht. Returns false if resize isn't needed.
 * @param {Struct.MajorGUI} Major Description
 * @param {real} [wid] Description
 * @param {real} [ht] Description
 * @param {Id.DsMap} [parent] Description
 * @returns {Bool}
 */
function _resize(Major, wid = undefined, ht = undefined, parent = undefined, from_refresh = false) {
	var _curr = use_ref.current
	
	var old_size = Major.CanvasGetSize(_curr)
		
	var functional_wid = wid ?? self.wid,
		functional_ht = ht ?? self.ht
		
	var new_wid, new_ht
		
	self.wid = functional_wid
	self.ht = functional_ht
		
	if(parent) {
		new_wid = resolve_size(functional_wid, parent)
		new_ht = resolve_size(functional_ht, parent, true)
	} else {
		new_wid = real(functional_wid)
		new_ht = real(functional_ht)
	}
	
	if(old_size.x == new_wid && old_size.y == new_ht) return false
		
	var size = new Vector2(
		new_wid,
		new_ht
	)
	
	Major.CanvasSetSize(_curr, size)
	if(!from_refresh) CanvasGetUpdateSiblings(_curr)(_curr)
	
	return true
}

function _refresh_size(Major, parent) {
	resize(Major, wid, ht, parent, true)
}

function CanvasSetFlexUnits(fm_element, unit, is_vertical) {
	if(is_vertical) {
		ElementSetProperty(fm_element, unit, "v_unit")
	} else {
		ElementSetProperty(fm_element, unit, "h_unit")
	}
}

function CanvasGetFlexUnits(fm_element, is_vertical) {
	return ElementGetProperty(
		fm_element, 
		is_vertical
			? "v_unit"
			: "h_unit"
	) ?? 0
}

function CanvasSetUpdateChildren(fm_element, callback) {
	ElementSetProperty(fm_element, callback, "update_children")
}

function CanvasGetUpdateChildren(fm_element) {
	static default_callback = function() { }
	
	return ElementGetProperty(
		fm_element,
		"update_children"
	) ?? default_callback
}

function CanvasGetUpdateSiblings(fm_element) {
	static default_callback = function() { }
	
	var parent = ElementGetProperty(fm_element, "parent")
	
	if(!parent) return default_callback
	
	return ElementGetProperty(
		parent,
		"update_children"
	) ?? default_callback
}

function CanvasSetRenderChildren(fm_element, callback) {
	ElementSetProperty(fm_element, callback, "render_children")
}

function CanvasGetRenderChildren(fm_element) {
	static default_callback = function() { }
	
	return ElementGetProperty(
		fm_element,
		"render_children"
	) ?? default_callback
}