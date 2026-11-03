function CanvasUpdatePanelWithHover(fm_panel){
	if(IsHoverCanvasOptimized(fm_panel)) {
		if(!CanvasGetHovering(fm_panel)) {
			CanvasSetHovering(fm_panel, true)
			
			var _enter = CanvasGetEnterEvent(fm_panel)
			
			if(!is_undefined(_enter)) _enter(fm_panel)
		}
	} else {
		if(CanvasGetHovering(fm_panel)) {
			CanvasSetHovering(fm_panel, false)
			
			var _leave = CanvasGetLeaveEvent(fm_panel)
			
			if(!is_undefined(_leave)) _leave(fm_panel)
		}
	}
	
	if(CanvasGetQueueClear(fm_panel) ?? false) {
		var _size = ds_list_size(fm_panel[? "elements"]),
			_backup_list = ds_list_create()
			
		ds_list_copy(_backup_list, fm_panel[? "elements"])
		
		for (var i = 0; i < _size; i++) {
			var element = _backup_list[| i]
		
			ElementFree(element)
		}
		
		ds_list_destroy(_backup_list)
		
		CanvasSetQueueClear(fm_panel, false)
	}	
	
	if(CanvasGetQueueUpdate(fm_panel)) {
		CanvasGetRenderChildren(fm_panel)()
		CanvasGetUpdateChildren(fm_panel)()
		
		CanvasSetQueueUpdate(fm_panel, false)
	}
}

function CanvasGetHovering(fm_panel) {
	return ElementGetProperty(fm_panel, "isHovering")
}

function CanvasSetHovering(fm_panel, value) {
	return ElementSetProperty(fm_panel, value, "isHovering")
}

function CanvasGetEnterEvent(fm_panel) {
	return ElementGetProperty(fm_panel, "onEnter")
}

function CanvasSetEnterEvent(fm_panel, value) {
	return ElementSetProperty(fm_panel, value, "onEnter")
}

function CanvasGetLeaveEvent(fm_panel) {
	return ElementGetProperty(fm_panel, "onLeave")
}

function CanvasSetLeaveEvent(fm_panel, value) {
	return ElementSetProperty(fm_panel, value, "onLeave")
}

function CanvasGetQueueUpdate(fm_panel) {
	return ElementGetProperty(fm_panel, "queueUpdate")
}

function CanvasSetQueueUpdate(fm_panel, value) {
	return ElementSetProperty(fm_panel, value, "queueUpdate")
}

function CanvasGetQueueClear(fm_panel) {
	return ElementGetProperty(fm_panel, "queueClear")
}

function CanvasSetQueueClear(fm_panel, value) {
	return ElementSetProperty(fm_panel, value, "queueClear")
}