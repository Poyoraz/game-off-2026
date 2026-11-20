run_headless_animation(
	new PlaySpriteAnimation(spr_realistic_explosion, 1.5),
	x,
	y,
	depth - 10
)

var _player = collision_circle(
	x, y,
	radius,
	obj_player,
	false,
	true
)

if(instance_exists(_player)) {
	var _center_distance = (point_distance(x, y, _player.x, _player.y) / radius)
	var _dir = point_direction(x, y, _player.x, _player.y)
	
	var _relative_power = (1 - _center_distance / 2) * explosion_power
	
	var _x_dir = lengthdir_x(_relative_power, _dir),
		_y_dir = lengthdir_y(_relative_power, _dir) 
	
	_player.damage()
	
	_player.transmit_momentum(_x_dir, false, TransmitMomentumType.EXPLOSION)
	_player.transmit_momentum(_y_dir, true, TransmitMomentumType.EXPLOSION)
}