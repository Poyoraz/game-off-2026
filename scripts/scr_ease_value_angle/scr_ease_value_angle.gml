/// @function			scr_ease_value_angle(_value, _goal, _speed = 1, _is_exp = false, _min_exp_speed = 0.1)
/// @description		Slowly increases/decreases _value towards _goal and returns value
/// @param {Real}		_value		The value that will be changed
/// @param {Real}		_goal		The goal value will go towards
/// @param {Real}		[_speed]	How much should value increase at once (for exp the speed will be difference/_speed)
/// @param {Bool}		[_is_exp]	If the change is exponential or linear
/// @param {Real}		[_min_exp_speed]	If the change is exponential, what should the minimum change be
/// @return {Real}
function scr_ease_value_angle(_value, _goal, _speed = 1, _is_exp = false, _min_exp_speed = 0.02){
	var _diff = angle_difference(_goal, _value)
	var _sign = sign(_diff)
	var _real_speed = _is_exp
		? max(_min_exp_speed, abs(_diff/_speed))
		: _speed
		
	switch(_sign) {
		// VALUE IS BIGGER THAN GOAL
		case -1:
		case 1:
			if(abs(_diff) < _real_speed) return _goal
				return _value + _sign * _real_speed
		default:
			return _value
	}
}