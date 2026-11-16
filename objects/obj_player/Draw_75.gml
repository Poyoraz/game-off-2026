if(screen_transition > 0) {
	draw_set_alpha(screen_transition / 100)
	draw_set_colour(c_black)
	
	draw_rectangle(
		0,
		0,
		window_get_width() * 2,
		window_get_height() * 2,
		false
	)
	
	draw_set_alpha(1)
}