if(opacity == 0) return;

draw_set_alpha(0.2 * opacity)
draw_set_color(c_black)
draw_rectangle(0, 0, room_width, room_height, false)
draw_set_alpha(1)