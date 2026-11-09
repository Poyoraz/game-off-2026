function LinearCombinedAnimation(items = []) constructor {
	self.items = items
	
	current_item = array_shift(items)
	
	static action = function(item) {
		if(!is_undefined(current_item)) {
			current_item.action(item)
		}
	}
	
	static initialize = function(item) {
		if(!is_undefined(current_item)) {
			current_item.initialize(item)
		}
	}
	
	static cleanup = function(item) {
		if(!is_undefined(current_item)) {
			current_item.cleanup(item)
		}
	}
	
	static condition = function(item) {
		if(!is_undefined(current_item)) {
			if(current_item.condition(item)) {
				cleanup(item)
				
				current_item = array_shift(items)
				
				initialize(item)
			}
		}
		
		
		return current_item == undefined
	}
	
	static draw = function(item) {
		if(!is_undefined(current_item)) {
			current_item.draw(item)
		}
	}
	
	script_execute(BaseAnimation, action, condition, initialize, cleanup, draw)
}