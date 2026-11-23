function draw_partial_circle(x, y, innerRad, outerRad, length, offset = 0, preciseness = 6){
	draw_primitive_begin(pr_trianglestrip)
	
	for(var _i = 0; _i < length; _i += preciseness) {
		var i = _i + offset,
			_cos = dcos(i),
			_sin = dsin(i)
		
		draw_vertex(x + _cos*innerRad, y + _sin*innerRad)
	
		draw_vertex(x + _cos*outerRad, y + _sin*outerRad)
	}
	
	var i = length + offset,
		_cos = dcos(i),
		_sin = dsin(i)
		
	draw_vertex(x + _cos*innerRad, y + _sin*innerRad)
	
	draw_vertex(x + _cos*outerRad, y + _sin*outerRad)
	
	draw_primitive_end()
}