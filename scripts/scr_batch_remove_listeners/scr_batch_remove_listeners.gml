function scr_batch_remove_listeners(_signatures = []){
	array_foreach(
		_signatures,
		function(_item) {
			scr_remove_listener(_item)
		}
	)
}