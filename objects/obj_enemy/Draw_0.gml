draw_self()

weapon.draw(self)

if(instance_exists(projector)) {
	draw_set_colour(__projector_blocked ? c_red : c_lime)
	
	draw_line_width(
		x,
		y,
		projector.x,
		projector.y,
		3
	)
}