function UseRef(on_initialize = base_ref) constructor{
	self.on_initialize = on_initialize
	
	current = noone
	
	static setup = function(item) {
		current = item
		on_initialize(item)
	}
}