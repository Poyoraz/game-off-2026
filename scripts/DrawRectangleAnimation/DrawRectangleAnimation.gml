function DrawRectangleAnimation(left, up, right, down) constructor{
	context = [left, up, right, down]
	
	static condition = function(item) {
		return true
	}
	
	static draw = function(item) {
		draw_set_colour(c_red)
		
		draw_rectangle(
			context[0],
			context[1],
			context[2],
			context[3],
			false
		)
		
		show_debug_message(context)
	}
	
	script_execute(BaseAnimation, undefined, condition, undefined, undefined, draw)
}