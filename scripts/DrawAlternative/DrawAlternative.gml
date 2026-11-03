function ReadyDraw() {
	// Create a list for the canvases
	var canvases_list = ds_list_create()
	
	var root_canvas = global.MAJORGUI_MAIN_CANVAS
	
	// Get all grandchildren canvases under main canvas
	// This list will be a postfix representation of the ui tree
	// Meaning a node can only be drawn after it's children have been drawn
	// This list does not include the head
	get_canvases(root_canvas, canvases_list)
	
	var canvas_count = ds_list_size(canvases_list)
	
	// Draw the gui tree, starting with the leaves
	for(var i = 0; i < canvas_count; i++) {
		var fm_canvas = canvases_list[| i]
		
		if (!fm_canvas[? "active"]) {
			continue
		}
		
		if (!surface_exists(fm_canvas[? "surface"])) {
			fm_canvas[? "surface"] = surface_create(fm_canvas[? "size"].x, fm_canvas[? "size"].y)
		}
		
		surface_set_target(fm_canvas[? "surface"])
		
		var bCol = fm_canvas[? "bCol"]
		
		draw_clear_alpha(
			make_color_rgb(
				bCol.x, 
				bCol.y, 
				bCol.z
			), 
			bCol.w / 255
		)
		
		var old_blend_mode = gpu_get_blendmode()
		if(bCol.w == 0) {
			gpu_set_over_empty()
		} else {
			gpu_set_over_non_empty()
		}
		
		if (fm_canvas[? "BeforeDraw"] != noone) {
			fm_canvas[? "BeforeDraw"](fm_canvas)
		}		

		var elements = fm_canvas[? "elements"],
			_elem_count = ds_list_size(elements)
		
		for (var j = 0; j < _elem_count; j++) {
			var _fm_canvas = elements[| j]
			
			if (!_fm_canvas[? "active"]) {
				continue
			}
			var pos = GetElementStartPosOffScreen(_fm_canvas)
			var px = pos.x,
				py = pos.y
			
			delete pos
		
			if (_fm_canvas[? "shader"] == noone) {
				draw_surface(_fm_canvas[? "surface"], px, py)
			}
			else {
				shader_set(_fm_canvas[? "shader"])
				if (_fm_canvas[? "shaderParameterScript"] != noone) {
					_fm_canvas[? "shaderParameterScript"](_fm_canvas)
				}
				draw_surface(_fm_canvas[? "surface"], px, py)
				shader_reset()
			}
		}
			
		gpu_set_over_non_empty()
		if (fm_canvas[? "AfterDraw"] != noone) {
			fm_canvas[? "AfterDraw"](fm_canvas);
		}
		
		surface_reset_target()
		gpu_set_blendmode(old_blend_mode)
	}
	
	// Cleanup
	ds_list_destroy(canvases_list)
}

function DrawRoot() {
	var root_canvas = global.MAJORGUI_MAIN_CANVAS
		
	var elements = root_canvas[? "elements"],
		_elem_count = ds_list_size(elements)
		
	var _fm_canvas = elements [| 0]
	
	if (_fm_canvas[? "active"]) {
		var px = 0,
			py = 0
		
		draw_surface(_fm_canvas[? "surface"], px, py)
	}
}

function DrawModals() {
	var root_canvas = global.MAJORGUI_MAIN_CANVAS
		
	var elements = root_canvas[? "elements"],
		_elem_count = ds_list_size(elements)
		
	for (var j = 1; j < _elem_count; j++) {
		var _fm_canvas = elements[| j]
		
		if (!_fm_canvas[? "active"]) {
			continue
		}
			
		var px = 0,
			py = 0
		
		draw_surface(_fm_canvas[? "surface"], px, py)
	}
}

function get_canvases(fm_canvas, canvas_list) {
	// If the canvas has children, recursively add them
	var _children_size = ds_list_size(fm_canvas[? "elements"])
	
	for (var i = 0; i < _children_size; i++) {
		var element = fm_canvas[? "elements"][| i]
			
		__get_canvases(element, canvas_list)
	}
}

function __get_canvases(fm_canvas, canvas_list) {
	
	// If canvas inactive, ignore
	if (!fm_canvas[? "active"]) {
		return
	}
	
	// If the canvas has children, recursively add them
	var _children_size = ds_list_size(fm_canvas[? "elements"])
	
	for (var i = 0; i < _children_size; i++) {
		var element = fm_canvas[? "elements"][| i]
			
		__get_canvases(element, canvas_list)
	}
	
	ds_list_add(canvas_list, fm_canvas)
}