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