function end_step_animatable(){
	if(!is_undefined(current_item)) {
		if(current_item.condition(self)) {
			current_item.cleanup(self)
		
			start_item()
		}
	}
}