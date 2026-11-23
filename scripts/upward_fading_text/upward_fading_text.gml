function upward_fading_text(text, _speed = 2, end_time = 100){
	var memory = {
		text,
		_speed,
		end_time,
		timer: 0
	}
	
	return new ParallelCombinedAnimation([
		new DrawAnimation(
			method({ memory }, function(item) {
				var _memory = memory
				
				with(item) {
					_memory.text
						.blend(c_white, 1 - (_memory.timer / _memory.end_time))
						.draw(x, y)
				}
			})
		),
		new LinearCombinedAnimation([
			new BaseAnimation(
				method(memory, function(item) {
					timer += _speed
					item.y -= _speed
				}),
				method(memory, function() {
					return timer > end_time
				})
			),
		])
	])
}