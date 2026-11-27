function screen_shake(duration){
	
	static SHAKE_EFFECT = __get_shake_fx_changable()
	
	var wait = new WaitAnimation(duration)
	
	// I AM A VERY LAZY PERSON DO NOT BE LIKE ME
	wait.action = method(wait, function() {
		duration--
	})
	
	return new ParallelCombinedAnimation([
		wait,
		new BaseAnimation(
			function() {
				fx_set_parameter(
					screen_shake.SHAKE_EFFECT, 
					"g_Magnitude", 
					fx_get_parameter(
						screen_shake.SHAKE_EFFECT, 
						"g_Magnitude"
					) - 0.5
				)
			},
			function() {
				return fx_get_parameter(
					screen_shake.SHAKE_EFFECT, 
					"g_Magnitude"
				) <= 0
			},
			function() {
				fx_set_parameter(screen_shake.SHAKE_EFFECT, "g_Magnitude", 10)
				layer_set_fx("ShakeLayer", screen_shake.SHAKE_EFFECT)
			},
			function() {
				layer_clear_fx("ShakeLayer")
			}
		),
	])
}

function __get_shake_fx_changable() {
	var _fx = fx_create("_filter_screenshake")
	fx_set_parameter(_fx, "g_ShakeSpeed", 3)
	
	return _fx
}