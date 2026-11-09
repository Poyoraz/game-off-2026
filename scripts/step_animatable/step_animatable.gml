function step_animatable(){
	if(!is_undefined(current_item)) {
		current_item.action(self)
	}
}