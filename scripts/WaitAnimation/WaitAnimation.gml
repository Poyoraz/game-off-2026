function WaitAnimation(duration) constructor{
	self.duration = duration
	
	static action = function(item) {
		duration--
	}
	
	static condition = function(item) {
		return duration <= 0
	}
	
	script_execute(BaseAnimation, action, condition)
}