// Inherit the parent event
event_inherited();

on_enter = function(this) {
	on_collect(this)
	
	instance_destroy(this)
	
	
}