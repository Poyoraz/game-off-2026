/// @desc Function Gets the current song based on if there's enemies on the field
/// @returns {Asset.GMSound}

function scr_get_current_song(){
	return instance_exists(obj_enemy)
		? combat_theme
		: calm_theme
}