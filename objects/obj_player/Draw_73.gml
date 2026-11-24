if(ui_transparency > 0) {
	draw_set_alpha(
		min(ui_transparency / 100, 0.5)
	)
	
	draw_set_colour(c_red)
	draw_partial_circle(
		x,
		y,
		120,
		140,
		360,
		0,
		10
	)
	
	draw_set_colour(c_green)
	draw_partial_circle(
		x,
		y,
		120,
		140,
		visual_health_perc * 3.6,
		0,
		10
	)
	
	draw_set_alpha(1)
}

var _dir = point_direction(x, y, mouse_x, mouse_y)

var _ind_x = x + lengthdir_x(50, _dir),
	_ind_y = y + lengthdir_y(50, _dir)

draw_sprite_ext(
	spr_hook_indicator,
	-1,
	_ind_x,
	_ind_y,
	0.2,
	0.2,
	_dir,
	c_white,
	0.9
)