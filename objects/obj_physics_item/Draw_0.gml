draw_self()

draw_set_colour(c_gray)
draw_text(x,y, { bottom_collision, top_collision, right_collision, left_collision })
draw_text(x,y + 16, { vertical_speed, horizontal_speed })

draw_rectangle(bbox_left - 2, bbox_top - 2, bbox_right + 2, bbox_bottom + 2, true)