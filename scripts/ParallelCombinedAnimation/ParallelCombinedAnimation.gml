function ParallelCombinedAnimation(items = []) constructor {
	self.items = items
	
	all_items = array_easy_copy(items)
	
	static action = function(item) {
		for (var i = 0; i < array_length(items); ++i) {
		    var animation_item = items[i]
			
			animation_item.action(item)
		}
	}
	
	static initialize = function(item) {
		for (var i = 0; i < array_length(items); ++i) {
		    var animation_item = items[i]
			
			animation_item.initialize(item)
		}
	}
	
	static cleanup = function(item) {
		for (var i = 0; i < array_length(all_items); ++i) {
		    var animation_item = all_items[i]
			
			animation_item.cleanup(item)
		}
	}
	
	static condition = function(item) {
		var destruction_arr = []
		
		for (var i = 0; i < array_length(items); ++i) {
		    var animation_item = items[i]
			
			var cond = animation_item.condition(item)
			
			if(cond) array_push(destruction_arr, i)
		}
		
		if(array_length(destruction_arr) == 0) return false
		
		var arr = array_filter(items, method({ destruction_arr }, function(item, index) {
			return !array_contains(destruction_arr, index)
		}))
		
		array_copy(items, 0, arr, 0, array_length(arr))
		array_resize(items, array_length(arr))
		
		return array_length(items) == 0
	}
	
	static draw = function(item) {
		for (var i = 0; i < array_length(all_items); ++i) {
		    var animation_item = all_items[i]
			
			animation_item.draw(item)
		}
	}
	
	script_execute(BaseAnimation, action, condition, initialize, cleanup, draw)
}