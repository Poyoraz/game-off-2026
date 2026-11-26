function scr_hook_head_attached(){
	if(instance_exists(obj_hook)) return false
	if(instance_exists(obj_failed_hook)) return false
	if(obj_player.disable_hook) return false
	
	return true
}