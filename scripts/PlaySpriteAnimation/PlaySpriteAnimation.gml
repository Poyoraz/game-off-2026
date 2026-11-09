function PlaySpriteAnimation(_sprite, _scale = 1, _repeat_count = 1) constructor{
	sprite = _sprite
	repeat_count = _repeat_count
	
	timer = 0
	
	scale = _scale
	
	sprite_speed = sprite_get_speed(sprite)
	sprite_count = sprite_get_number(sprite)
	
	// GET DURATION OF ONE SPRITE LOOP IN FRAMES
	duration = (game_get_speed(gamespeed_fps) / sprite_speed) * sprite_count
	
	static condition = function(item) {
		return repeat_count <= 0
	}
	
	static action = function(parent) {
		timer++
		
		if(timer >= duration) {
			timer -= duration
			
			repeat_count--
		}
	}
	
	static draw = function(parent) {
		var _sprite = sprite,
			_image_index = floor(timer / (game_get_speed(gamespeed_fps) / sprite_speed)),
			_scale = scale
		
		with(parent) {
			draw_sprite_ext(_sprite, _image_index, x, y, _scale, _scale, 0, c_white, 1)
		}
	}
	
	script_execute(BaseAnimation, action, condition, undefined, undefined, draw)
}