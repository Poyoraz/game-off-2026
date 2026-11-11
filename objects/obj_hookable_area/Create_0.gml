// Inherit the parent event
event_inherited();

on_grapple_hook = method(self, function() {
	obj_player.set_bash(self)
		
	return noone
})