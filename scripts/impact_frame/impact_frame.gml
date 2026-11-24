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
			},
			function() {
				layer_clear_fx("Instances")
			}
		),
		new BaseAnimation(
			function() {
			},
			function() {
				return true
			},
			function() {
				layer_set_fx("Background", impact_frame.WHITEN_EFFECT)
			},
			function() {
				layer_clear_fx("Background")
			}
		),
	])
}

function __get_whiten_fx() {
	var _fx = fx_create("_filter_contrast")
	fx_set_parameter(_fx, "g_ContrastIntensity", 2)
	fx_set_parameter(_fx, "g_ContrastBrightness", 2)
	fx_set_single_layer(_fx, true)
	
	return _fx
}

function __get_darken_fx() {
	var _fx = fx_create("_filter_tintfilter")
	fx_set_parameter(_fx, "g_TintCol", [0, 0, 0, 1])
	fx_set_single_layer(_fx, true)
	
	return _fx
}