function BaseAnimation(
	action = undefined, 
	condition = undefined, 
	initialize = undefined,
	cleanup = undefined,
	draw = undefined
) constructor {
	self.action = action ?? function(item) {
		
	}
	
	self.condition = condition ?? function(item) {
		return true
	}
	
	self.initialize = initialize ?? function(item) {
		
	}
	
	self.cleanup = cleanup ?? function(item) {
		
	}
	
	self.draw = draw ?? function(item) {
		
	}
}