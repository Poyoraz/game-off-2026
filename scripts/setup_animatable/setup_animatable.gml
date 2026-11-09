/// @desc Sets up the animatable actions for the called object, animations can be set with "set_animations"
function setup_animatable(){
	animation_queue = []

	current_item = undefined

	start_item = method(self, function() {
		current_item = array_shift(animation_queue)
	
		if(!current_item) return;
	
		current_item.initialize(self)
	})

	set_animations = method(self, function(items) {
		animation_queue = array_concat(animation_queue, items)
	
		start_item()
	})
}