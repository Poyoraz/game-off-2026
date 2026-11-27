// Inherit the parent event
event_inherited()

_physics_item_on_collide = on_collide

invincibility = 12

on_collide = method(self, function(collidee, vertical = false) {
	if(collidee.object_index == obj_enemy || object_is_ancestor(collidee.object_index, obj_enemy)) {
		//increase damage on enemies
		if(vertical) {
			vertical_speed *= 2
		} else {
			horizontal_speed *= 2
		}
		
		alarm[0] = 1
	}
	
	_physics_item_on_collide(collidee, vertical)
	
	if(invincibility > 0) return;
	alarm[0] = 1
})

