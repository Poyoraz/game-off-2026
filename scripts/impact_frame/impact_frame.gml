function impact_frame(duration){
	
	static WHITEN_EFFECT = __get_whiten_fx()
	static DARKEN_EFFECT = __get_darken_fx()
	
	return new ParallelCombinedAnimation([
		new WaitAnimation(duration),
		new PlaySpriteAnimation(spr_impact_frame, 1),
		new BaseAnimation(
			function() {
			},
			function() {
				return true
			},
			function() {
				layer_set_fx("Instances", impact_frame.DARKEN_EFFECT)
				layer_set_fx("Player", impact_frame.DARKEN_EFFECT)
				layer_set_fx("Background", impact_frame.WHITEN_EFFECT)
				layer_set_fx("ShakeLayer", impact_frame.SHAKE_EFFECT)
			},
			function() {
				layer_clear_fx("Instances")
				layer_clear_fx("Player")
				layer_clear_fx("Background")
				layer_clear_fx("ShakeLayer")
			}
		)
	])
}