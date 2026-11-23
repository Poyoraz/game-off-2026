// Inherit the parent event
event_inherited();

on_collect = function() {
	global.persistent_player_data.hp = min(
		global.persistent_player_data.hp + 1,
		4
	)
	obj_player.ui_transparency = 500
}