var _dir = (floor((point_direction(x, y, mouse_x, mouse_y) + 22.5) / (360 / 8)) mod 8) * 45

air_drag = 0

alarm[0] = 10

horizontal_speed = lengthdir_x(35, _dir)
vertical_speed = lengthdir_y(35, _dir)