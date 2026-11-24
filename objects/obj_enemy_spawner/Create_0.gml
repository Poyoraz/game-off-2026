on_enter = function(this) {
	var _enemy = instance_create_depth(x, y, depth, spawned_item, spawn_params)
	
	with(obj_enemy_group_handler) {
		on_enemy_spawn(this, _enemy)
	}
	instance_destroy(this)
}