function EnemyLaserGun() : EnemyWeapon() constructor{
	initial_cooldown = 400
	
	cooldown = initial_cooldown
	range = 1600
	
	laser_direction = 90

	static tick = function(enemy) {
		var _distance = point_distance(enemy.x, enemy.y, obj_player.x, obj_player.y)
		
		if(_distance < range) {
			laser_direction = scr_ease_value_angle(
				laser_direction,
				point_direction(enemy.x, enemy.y, obj_player.x, obj_player.y),
				15,
				true,
			)
			
			if(cooldown == initial_cooldown) {
				scr_play_sound(snd_robot_lock_on)
			} else if(cooldown > 150) {
				if(cooldown mod 60 == 0) scr_play_sound(snd_robot_lock_on)
			} else if(cooldown > 100) {
				if(cooldown mod 30 == 0) scr_play_sound(snd_robot_lock_on)
			} else if(cooldown > 30) {
				if(cooldown mod 15 == 0) scr_play_sound(snd_robot_lock_on)
			} else {
				if(cooldown mod 10 == 0) scr_play_sound(snd_robot_lock_on)
			}
		
			cooldown--
			
			if(cooldown < 0) {
				var dir = laser_direction
			
				var _x_goal = enemy.x + lengthdir_x(_distance, dir),
					_y_goal = enemy.y + lengthdir_y(_distance, dir)
				
				var _player = collision_line(enemy.x, enemy.y, _x_goal, _y_goal, obj_player, false, true)
				
				show_debug_message([enemy.x, enemy.y, _x_goal, _y_goal])
				show_debug_message(_player)
				
				if(instance_exists(_player)) {
					_player.damage()
				}
				
				cooldown = initial_cooldown
			}
		} else {
			cooldown = initial_cooldown
		}
	}
	
	static draw = function(enemy) {
		if(cooldown < initial_cooldown) {
			var dir = laser_direction
				
			draw_sprite_ext(
				(cooldown < 90 && cooldown mod 10 < 3) ? spr_laser_alarm : spr_laser,
				-1,
				enemy.x,
				enemy.y,
				range * 2,
				5,
				dir,
				c_white,
				1 - (cooldown / initial_cooldown) / 2
			)
		}
	}

}