event_inherited()

on_grapple_pull = method(self, function(force, dir) {
	var _block = instance_create_depth(x, y, obj_player.depth - 1, obj_malleable_block)
		
	obj_player.set_bash(_block)
		
	return
})