function DrawAnimation(draw) constructor{
	self.draw = draw
	
	static condition = function(item) {
		return true
	}
	
	script_execute(BaseAnimation, undefined, condition, undefined, undefined, draw)
}