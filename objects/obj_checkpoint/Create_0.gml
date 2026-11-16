event_inherited()

interact = function() {
	if(alarm[11] > 0) return;
	
	alarm[11] = 120
	
	run_headless_animation(
		new LinearCombinedAnimation([
			new PlaySpriteAnimation(spr_saved_anim, 1.5)
		]),
		x,
		y - 50,
		depth - 10
	)
	
	SaveHandler.file.activate_checkpoint()
	
	save_game()
}