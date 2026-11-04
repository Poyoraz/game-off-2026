draw_primitive_begin_texture(pr_trianglestrip, _texture)

var _line = line
var _arr_len = array_length(line)

draw_text(16, 16, $"currently editing {_line[curr]}")

draw_set_colour(c_orange)

var texture_map = [
	[0, 0],
	[0, 1],
	[1, 0],
	[1, 1],
]

for (var i = 0; i < _arr_len; ++i) {
    var item = _line[i]
	
	var _text_map = texture_map[i mod 4]
	
	draw_vertex_texture(item.x, item.y, _text_map[0], _text_map[1])
}

draw_set_colour(c_white)

draw_primitive_end()