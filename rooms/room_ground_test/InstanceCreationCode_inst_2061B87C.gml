interact = function(this) {
	
	run_headless_animation(
		new LinearCombinedAnimation([
			new PlaySpriteAnimation(spr_realistic_explosion, 1.5)
		]),
		x,
		y - 50,
		depth - 10
	)
}