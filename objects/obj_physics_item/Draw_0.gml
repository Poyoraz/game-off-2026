draw_self()

draw_set_colour(c_gray)
draw_text(16,y, { bottom_collision, top_collision, right_collision, left_collision })
draw_text(16,y + 16, { vertical_speed, horizontal_speed })

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)