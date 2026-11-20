function EnemyBrainChase() : EnemyBrain() constructor{
	
	static tick = function(enemy) {
		var player_dis = abs(obj_player.x - enemy.x)
		var player_dir = sign(obj_player.x - enemy.x)

		var social_dis = enemy.social_distancing,
			follow_buffer = enemy.follow_buffer

		var too_close = player_dis - social_dis

		if ((social_dis - follow_buffer) < player_dis && player_dis < (social_dis + follow_buffer)) {
			enemy.move_dir = 0;
		} else if (too_close < 0) {
			enemy.move_dir = -player_dir;	
		} else {
			enemy.move_dir = player_dir
		}
	}
}