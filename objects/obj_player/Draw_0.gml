image_alpha = invincibility > 0 ? 0.8 : 1

var _spr_ = get_sprite()

draw_sprite_ext(
	_spr_[0],
	_spr_[1],
	x,
	y,
	facing_left ? -0.68 : 0.68,
	0.68,
	direction,
	image_blend,
	image_alpha
)

draw_set_alpha(1)

if(instance_exists(bashing)) {
	if(!hook_bash) {
		with (bashing) {
			var _en_x = x,
				_en_y = y
	
			x = other.x
			y = other.y

			event_perform(ev_draw, ev_draw_normal)

			x = _en_x
			y = _en_y
	
		}
	}
	
	var _dir = point_direction(x, y, mouse_x, mouse_y)
	
	var _arrow_x = lengthdir_x(175, _dir),
		_arrow_y = lengthdir_y(175, _dir)
	
	draw_set_colour(c_purple)
	draw_arrow(x, y, x + _arrow_x, y + _arrow_y, 15)
	
	draw_text(x, y, _dir)
}

if(dash_cooldown > 0) {
	draw_healthbar(
		x - 25, 
		bbox_top - 35, 
		x + 25, 
		bbox_top - 40, 
		(max_dash_cooldown - dash_cooldown) / max_dash_cooldown * 100,
		c_white,
		c_red,
		c_green,
		0,
		true,
		false
	)
}