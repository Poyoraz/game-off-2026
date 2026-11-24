enemies = []

on_clear = method(self, function() {

})

on_any_death = method(self, function(_enemy) {
	
	if(!array_contains(enemies, _enemy.id)) return;
	
	array_delete(
		enemies,
		array_index_of_value(enemies, _enemy.id),
		1
	)
	
	if(array_length(enemies) == 0) {
		on_clear()
		instance_destroy()
	}
})

on_enemy_spawn = method(self, function(_enemy_spawner, _enemy) {
	if(!array_contains(enemies, _enemy_spawner.id)) return;
	
	enemies[array_index_of_value(enemies, _enemy_spawner.id)] = _enemy.id
})