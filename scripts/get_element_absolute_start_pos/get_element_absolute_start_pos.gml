function get_element_absolute_start_pos(fm_element){
	var valX = 0,
		valY = 0,
		curr = fm_element
		
	while(curr != global.MAJORGUI_MAIN_CANVAS) {
		var pos = GetElementStartPosOffScreen(curr)
		
		valX += pos.x
		valY += pos.y
		
		curr = CanvasGetParent(curr)
	}
	
	return {
		x: valX,
		y: valY
	}
}