function EnemyBrainGroundPatrol() : EnemyBrain() constructor{
	
	pause_timer = 0
	
	convo_timer = 0
	
	
	static tick = function(enemy) {
		var move_dir = enemy.move_dir
		
		convo_timer--
		
		if(irandom_range(0, 600) == 5 && convo_timer < 0) {
			scr_play_sound(
				choose(
					snd_robot_convo_1, snd_robot_convo_1
				)
			)
			
			convo_timer = 600
		}
		
		if(move_dir == 0) {
			enemy.move_dir = 1
		} else if(move_dir == 1 && enemy.right_collision) {
			if(pause_timer == 0) {
				pause_timer = 10
			} else if(pause_timer > 1) {
				pause_timer--
			} else {
				enemy.move_dir = -1
			}
		} else if(move_dir == -1 && enemy.left_collision) {
			
			if(pause_timer == 0) {
				pause_timer = 10
			} else if(pause_timer > 1) {
				pause_timer--
			} else {
				enemy.move_dir = 1
			}
		}
	
		if(point_distance(enemy.x, enemy.y, obj_player.x, obj_player.y) < enemy.social_distancing) 
			with(enemy) {
				scr_play_sound(
					choose(snd_robot_alert_1, snd_robot_alert_2)
				)
				scr_change_enemy_state(EnemyStates.CHASE_PLAYER)
			}
	}
}