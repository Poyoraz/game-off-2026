event_inherited()

_terrain_on_grapple_hook = on_grapple_hook
on_grapple_hook = method(self, function() {
	return noone
})

on_collided = method(self, function(collided) {
	collided.damage()
})