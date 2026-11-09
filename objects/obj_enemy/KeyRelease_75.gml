instance_create_depth(
	x,
	y,
	depth - 1,
	obj_bullet,
	{
		direction: point_direction(x, y, obj_player.x, obj_player.y)
	}
)