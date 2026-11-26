var _in_hit_lag = hit_lag > 0

draw_sprite_ext(
	sprite_index,
	image_index,
	x + (_in_hit_lag ? irandom_range(-5, 5) : 0),
	y + (_in_hit_lag ? irandom_range(-5, 5) : 0),
	image_xscale,
	image_yscale,
	direction,
	image_blend,
	image_alpha
)

weapon.draw(self)

draw_text_scribble(x, y, $"[fnt_large][c_black]{brain_disabled_timer}")

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