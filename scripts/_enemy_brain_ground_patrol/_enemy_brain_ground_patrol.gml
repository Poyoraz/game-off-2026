function _enemy_brain_ground_patrol(){
	if(move_dir == 0) {
		move_dir = 1
	} else if(move_dir == 1 && right_collision) {
		move_dir = -1
	} else if(move_dir == -1 && left_collision) {
		move_dir = 1
	}
	
	if(point_distance(x, y, obj_player.x, obj_player.y) < social_distancing) 
		scr_change_enemy_state(EnemyStates.CHASE_PLAYER)
}