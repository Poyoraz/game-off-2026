function RunFunctionAnimation(callback) constructor{
	self.callback = callback
	
	static condition = function(item) {
		return true
	}
	
	static initialize = function(item) {
		if(!is_undefined(callback)) callback(item)
	}
	
	script_execute(BaseAnimation, undefined, condition, initialize)
}