// Inherit the parent event
event_inherited()

if(ui_transparency > 0) {
	draw_set_alpha(
		min(ui_transparency / 100, 0.5)
	)
	
	draw_set_colour(c_red)
	draw_partial_circle(
		x,
		y,
		80,
		100,
		360,
		0,
		10
	)
	
	draw_set_colour(c_green)
	draw_partial_circle(
		x,
		y,
		80,
		100,
		visual_health_perc * 3.6,
		0,
		10
	)
	
	draw_set_alpha(1)
}