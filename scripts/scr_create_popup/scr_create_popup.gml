enum POPUP_TYPES {
	INFO,
	ERROR
}

/**
 * Function Description
 * @param {string} [msg] Description
 * @param {real} [type] Description
 */
function scr_create_popup(msg = "", type = POPUP_TYPES.ERROR){
	var bg_color,
		text_color
		
	switch(type) {
		case POPUP_TYPES.INFO:
			bg_color = c_blue
			text_color = c_white
			break
		case POPUP_TYPES.ERROR:
			bg_color = c_red
			text_color = c_white
			break
	}
	
	instance_create_depth(0, 0, -1000, obj_popup, {
		message: msg,
		bg_color,
		text_color
	})
}