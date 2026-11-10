event_inherited()

_terrain_on_grapple_hook = on_grapple_hook
on_grapple_hook = method(self, function() {
	if(shock_enabled) {
		obj_player.damage()
	
		return noone	
	}
	
	_terrain_on_grapple_hook()
})

on_collided = method(self, function(collided) {
	if(shock_enabled) {
		collided.damage()
	
		return noone	
	}
})

image_blend = shock_enabled ? c_blue : c_white

disable_shock = method(self, function() {
	shock_enabled = false
	image_blend = c_white
})

enable_shock = method(self, function() {
	shock_enabled = true
	image_blend = c_blue
})