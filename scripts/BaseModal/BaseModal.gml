function BaseModal(
	children, 
	wid = 500, 
	ht = 300, 
	closable = false,
	title = "",
	submit = noone,
	on_cancel = noone,
	close_text = "Close Popup",
	submit_text = "Submit"
) : BaseRoom() constructor{
	static count = 0
	
	modal_ref = new UseRef(function(_item) {
		var pos = obj_menu.Major.CanvasGetPosition(_item)
		
		obj_menu.Major.CanvasSetPosition(_item, new Vector3(
			pos.x,
			pos.y,
			array_length(obj_menu.modals) * 10
		))
	})
	
	static unload = function() {
		_children.unload()
	}
	
	cancel_event = method({ on_cancel }, function() {
		if(on_cancel != noone) on_cancel()
		
		pop_modal()
	})
	
	_children = children
	var ModalChildren = [
		new ColNode([
			children
		], {
			wid: flex,
			ht: flex,
			has_bg: c_dkgray,
		})
	]
	
	// TODO: add submit button
	
	if(submit != noone) {
		array_push(
			ModalChildren, 
			new ButtonNode(submit_text, {
				on_click: submit,
				wid: flex,
				ht: 32
			})
		)
	}
	
	if(string_length(title) > 0) {
		array_insert(
			ModalChildren,
			0,
			new RowNode([
				new TextNode(title, { emitter_event: "KEYWORD_MODAL" })
			], {
				wid: flex,
				ht: 32,
				has_bg: c_dkgray,
			})
		)
	}
	
	if(closable) {
		array_push(
			ModalChildren, 
			new ButtonNode(close_text, {
				on_click: cancel_event,
				wid: flex,
				ht: 32
			})
		)
	}
	
	page = new RowNode([
		new ColNode(ModalChildren, {
			wid,
			ht,
			has_bg: c_ltgray,
			v_gap: 8,
			h_gap: 8
		})
	], {
		wid: "auto",
		ht: "auto",
		z: 10,
		bg_opa: 0.1,
		bg_col: c_black,
		allcenter,
		auto_fit: true,
		use_ref: modal_ref
	})
}