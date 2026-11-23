function scr_create_after_image_animation(_x, _y, _dir, sprite){
	run_headless_animation(
		new ParallelCombinedAnimation([
			new AfterImage(_dir, 20, sprite)
		]),
		_x,
		_y,
		depth - 1
	)

}

function AfterImage(dir, timer, sprite) constructor {
	self.dir = dir
	self.timer = timer
	self.max_timer = timer
	self.sprite = sprite
	
	static action = function() {
		timer--
	}
	
	static condition = function() {
		return timer < 0
	}
	
	static draw = function(parent) {
		var sprite = self.sprite
		var timer = self.timer
		
		var _offset_x = lengthdir_x(max_timer - timer, dir) * 0.25,
			_offset_y = lengthdir_y(max_timer - timer, dir) * 0.25,
			_timer_perc = timer/max_timer
		
		with(parent) {
			draw_sprite_ext(sprite, -1, x - _offset_x, y  - _offset_y, 1, 1, 0, c_white, _timer_perc - .2)
		}
	}
	
	script_execute(
		BaseAnimation, 
		action, 
		condition, 
		undefined, 
		undefined, 
		draw
	)
}