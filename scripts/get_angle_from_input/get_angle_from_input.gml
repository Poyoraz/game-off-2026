function get_angle_from_input(h_input, v_input){
	static DIRECTION_MAP = [
		[135, 90, 45],
		[180, 0,  0],
		[225, 270, 315]
	]

	return DIRECTION_MAP[
		v_input + 1
	][
		h_input + 1
	]
}