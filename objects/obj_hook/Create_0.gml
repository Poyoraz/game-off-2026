grappled = noone

list = ds_list_create()

horizontal_speed = lengthdir_x(speed, direction)
vertical_speed = lengthdir_y(speed, direction)

speed = 0

image_xscale = 0.15
image_yscale = 0.15

// sprite_get_width(spr_chain_link_face) -> 440

CHAIN_STEP_SIZE = (440 - 150) * image_xscale

stop_speed = function(contacted) {
	if(contacted.object_index == obj_player) return false;
	
	var result = contacted.on_grapple_hook()
	
	if(!instance_exists(result)) {
		scr_play_sound(snd_grapple_blocked)
	
		fail_hook()
		return true
	}
	
	scr_play_sound(snd_grapple_impact)

	grappled = result
	horizontal_speed = 0
	vertical_speed = 0
	
	return true
}

fail_hook = function() {
	scr_play_sound(snd_grapple_suckback)
		
	instance_create_depth(
		x,
		y,
		depth,
		obj_failed_hook,
		{
			direction
		}
	)
	instance_destroy()
}

__initialized = false
alarm[0] = 1