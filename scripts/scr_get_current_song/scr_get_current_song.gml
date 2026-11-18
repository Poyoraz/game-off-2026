/// @desc Function Gets the current song based on if there's enemies on the field
/// @returns {Asset.GMSound}

function scr_get_current_song(){
	if(instance_exists(obj_enemy) && combat_theme != noone) 
		return combat_theme
	
	if(instance_exists(obj_enemy_spawner) && calm_theme != noone) 
		return calm_theme
	
	return ambient_theme
}