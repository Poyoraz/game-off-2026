var _cam_x = camera_get_view_x(obj_camera.camera) 

for (var i = 0; i < asset_count; ++i) {
    var _asset = asset_order[i]
	
	var _offset = -6109 * 0.2
		* (_cam_x / (room_width - 1920 * obj_camera.zoom_level)) 
		* distance_multipliers[i]
		
	var _repeat_times = room_width
	
	draw_sprite_ext(
		_asset,
		-1,
		_offset,
		0,
		-asset_size_multiplier,
		asset_size_multiplier,
		0,
		c_white,
		1
	)
	
	draw_sprite_ext(
		_asset,
		-1,
		_offset,
		0,
		asset_size_multiplier,
		asset_size_multiplier,
		0,
		c_white,
		1
	)
	
	draw_sprite_ext(
		_asset,
		-1,
		_offset + asset_size_multiplier * 6109 * 2,
		0,
		-asset_size_multiplier,
		asset_size_multiplier,
		0,
		c_white,
		1
	)
}