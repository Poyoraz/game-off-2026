is_loading = array_length(loading_set) > 0

opacity = scr_ease_value(
	opacity,
	is_loading ? 1 : 0,
	0.1
)