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
		fail_hook()
		return true
	}

	grappled = result
	horizontal_speed = 0
	vertical_speed = 0
	
	return true
}

fail_hook = function() {
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