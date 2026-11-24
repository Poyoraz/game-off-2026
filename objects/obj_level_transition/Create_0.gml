event_inherited()

on_enter = function(this) {
	global.PLAYER_MARKER = this.target_marker
	scr_transition_level(this.target_room)
}