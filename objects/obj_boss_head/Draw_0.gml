
if(shockwave_radius > 0) {
	draw_set_colour(c_blue)
	draw_set_alpha(0.5)
	draw_partial_circle(
		x, 
		y, 
		max(0, shockwave_radius - 60),
		shockwave_radius,
		360
	)
	draw_set_alpha(1)
}

event_inherited()