enum EnemyStates {
	NONE = 0,
	GROUND_PATROL,
	AIR_PATROL,
	CHASE_PLAYER
}

function scr_change_enemy_state(enemy_state = EnemyStates.NONE) {
	static ENEMY_STATE_MAP = __scr_get_enemy_state_map()
	
	brain_func = ENEMY_STATE_MAP[enemy_state]
	current_state = enemy_state
}

function __scr_get_enemy_state_map() {
	var _enemy_map = []
	
	_enemy_map[EnemyStates.NONE] = _enemy_brain_none
	_enemy_map[EnemyStates.CHASE_PLAYER] = _enemy_brain_chase
	_enemy_map[EnemyStates.AIR_PATROL] = _enemy_brain_air_patrol
	_enemy_map[EnemyStates.GROUND_PATROL] = _enemy_brain_ground_patrol
	
	return _enemy_map
}