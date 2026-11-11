on_enter = function(this) {
	instance_destroy(this)
	
	run_headless_animation(
		new LinearCombinedAnimation([
			new PlaySpriteAnimation(spr_hello, 1.5),
			new PlaySpriteAnimation(spr_realistic_explosion, 1.5)
		]),
		x,
		y - 50,
		depth - 10
	)
}