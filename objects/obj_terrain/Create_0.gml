// Inherit the parent event
event_inherited()

on_collided = method(self, function(collided) {

})

on_grapple_pull = method(self, function(force, dir) {
	obj_hook.fail_hook()
})