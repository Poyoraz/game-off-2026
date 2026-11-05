

draw_self()
draw_text(x, y-16, grounded_timer)
draw_text(16, 16, horizontal_speed)

var _dir = (floor((point_direction(x, y, mouse_x, mouse_y) + 22.5) / (360 / 8)) mod 8) * 45

draw_sprite_ext(
	spr_arrow,
	-1,
	x,
	y,
	1,
	1,
	_dir,
	c_white,
	1
)