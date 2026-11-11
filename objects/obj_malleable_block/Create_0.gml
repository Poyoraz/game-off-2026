// Inherit the parent event
event_inherited()

_physics_item_on_collide = on_collide

invincibility = 12

on_collide = method(self, function(collidee, vertical = false) {
	_physics_item_on_collide(collidee, vertical)
	
	if(invincibility > 0) return;
	instance_destroy()
})

