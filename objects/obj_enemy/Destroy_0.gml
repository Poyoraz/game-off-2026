on_death()

with(obj_music_handler) {
	alarm[0] = 1
}

with(obj_enemy_group_handler) {
	on_any_death(other)
}