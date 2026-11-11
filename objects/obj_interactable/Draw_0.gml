if(alpha > 0) {
	draw_sprite_stretched_ext(
		spr_text_box,
		-1,
		x - box_width / 2 - 10, 
		y - box_height / 2 - 10,
		box_width + 20,
		box_height + 20,
		c_white,
		alpha
	)
	
	scrib
		.blend(c_white, alpha)
		.draw(
			x - box_width / 2, 
			y - box_height / 2,
			typist
		)
}