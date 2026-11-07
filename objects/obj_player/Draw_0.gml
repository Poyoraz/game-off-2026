

draw_self()
draw_text(x, y-16, coyote_timer)
draw_text(16, 16, horizontal_speed)

if(dash_cooldown > 0) {
	draw_healthbar(
		x - 25, 
		bbox_top - 25, 
		x + 25, 
		bbox_top - 30, 
		(max_dash_cooldown - dash_cooldown) / max_dash_cooldown * 100,
		c_white,
		c_red,
		c_green,
		0,
		true,
		false
	)
}

draw_set_colour(c_purple)
for (var i = 0; i < array_length(player_cast); ++i) {
    var _item = player_cast[i]
	draw_circle(_item[0], _item[1], 3, false)
}

draw_text(mouse_x, mouse_y - 20, $"{mouse_x} {mouse_y}")