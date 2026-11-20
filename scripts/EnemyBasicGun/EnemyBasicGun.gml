function EnemyBasicGun() : EnemyWeapon() constructor{
	cooldown = 400
	range = 800

	static tick = function(enemy) {
		if(point_distance(enemy.x, enemy.y, obj_player.x, obj_player.y) < range) {
			cooldown--
			
			if(cooldown < 0) {
				instance_create_depth(
					enemy.x,
					enemy.y,
					enemy.depth - 1,
					obj_bullet,
					{
						direction: point_direction(enemy.x, enemy.y, obj_player.x, obj_player.y)
					}
				)
				
				cooldown = 400
			}
		}
	}

}