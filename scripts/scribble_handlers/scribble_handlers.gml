/// @desc Function Updated version of the built in majorui drawer that uses scribble
/// @param {any*} fm_label Description
function label_draw_with_scribble(fm_label) {
	var _scribble_item = TextGetScribble(fm_label),
		tox = 0, toy = 0
		
	switch (LabelGetTextAlignment(fm_label).horizontal) {
		case ALIGN.LEFT: {
			tox = 0
		} break
		case ALIGN.CENTER: {
			tox = CanvasGetSize(fm_label).x / 2
		} break
		case ALIGN.RIGHT: {
			tox = CanvasGetSize(fm_label).x
		} break
	}
		
	switch (LabelGetTextAlignment(fm_label).vertical) {
		case ALIGN.TOP: {
			toy = 0
		} break
		case ALIGN.MIDDLE: {
			toy = CanvasGetSize(fm_label).y / 2
		} break
		case ALIGN.BOTTOM: {
			toy = CanvasGetSize(fm_label).y
		} break
	}
	
	_scribble_item
		.draw(tox, toy)
}

function build_scribble_item(fm_label){
	var Major = obj_menu.Major
	
	var color = Major.LabelGetColor(fm_label)
		
	var stringToBeDrawn = Major.LabelGetText(fm_label)
	if (Major.LabelGetPassword(fm_label)) { 
		stringToBeDrawn = string_repeat(
			Major.LabelGetPasswordCharacter(fm_label), 
			string_length(Major.LabelGetText(fm_label)
		)
	)}
	
	var styled_string = $"[{fm_label[? "fontName"]}][d#{make_color_rgb(color.x, color.y, color.z)}][alpha,{color.w}]{stringToBeDrawn}"
	
	TextSetHasRegion(fm_label, string_pos("[region", stringToBeDrawn) > 0)
	
	var 
		alignH = fa_left, 
		alignV = fa_top,
		text_alignment = Major.LabelGetTextAlignment(fm_label)
		
	switch (text_alignment.horizontal) {
		case ALIGN.LEFT: {
			alignH = fa_left
		} break
		case ALIGN.CENTER: {
			alignH = fa_center
		} break
		case ALIGN.RIGHT: {
			alignH = fa_right
		} break
	}
		
	switch (text_alignment.vertical) {
		case ALIGN.TOP: {
			alignV = fa_top
		} break
		case ALIGN.MIDDLE: {
			alignV = fa_middle
		} break
		case ALIGN.BOTTOM: {
			alignV = fa_bottom
		} break
	}
	
	var _scribble = scribble(styled_string)
		.wrap(
			ElementGetProperty(fm_label, "virtualContainerWidth")
		)
		.align(alignH, alignV)
	
	TextSetScribble(
		fm_label,
		_scribble
	)
	
	Major.CanvasSetSize(
		fm_label,
		new Vector2(
			_scribble.get_width(),
			_scribble.get_height()
		)
	)
}

function label_update_with_clickable(fm_label) {
	if(!TextGetHasRegion(fm_label)) return;
	
	if(IsHoverCanvasOptimized(fm_label)) {
		if(mouse_check_button_released(mb_left)) {	
			
			var pos = get_element_absolute_start_pos(fm_label)
			
			var region = TextGetScribble(fm_label).region_detect(
					pos.x,
					pos.y,
					mouse_x,
					mouse_y
				)
				
			if(is_undefined(region)) return;
			
			scr_emit_listener(
				TextGetEmitterEvent(fm_label),
				region
			)
		}
	}
};

function TextRebuild(fm_label, text) {
	
	var stringToBeDrawn = obj_menu.Major.LabelSetText(fm_label, text)
	
	build_scribble_item(fm_label)
}

function TextSetScribble(fm_label, _scribble) {
	ElementSetProperty(fm_label, _scribble, "Scribble")
}

function TextGetScribble(fm_label) {
	return ElementGetProperty(fm_label, "Scribble")
}

function TextSetHasRegion(fm_label, value) {
	ElementSetProperty(fm_label, value, "HasRegion")
}

function TextGetHasRegion(fm_label) {
	return ElementGetProperty(fm_label, "HasRegion") ?? false
}

function TextSetEmitterEvent(fm_label, value) {
	ElementSetProperty(fm_label, value, "EmitterEvent")
}

function TextGetEmitterEvent(fm_label) {
	return ElementGetProperty(fm_label, "EmitterEvent") ?? ""
}