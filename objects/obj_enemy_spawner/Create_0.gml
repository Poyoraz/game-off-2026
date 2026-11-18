on_enter = function(this) {
	instance_create_depth(x, y, depth, spawned_item, spawn_params)
	instance_destroy(this)
}