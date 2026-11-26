event_inherited()

if(place_meeting(x, y, obj_boss_box) && !has_bomb_box) {
	instance_destroy(obj_boss_box)
	
	scrib = scribble("[fnt_large]Press E").starting_format("fnt_main", c_black)

	box_width = scrib.get_width()
	box_height = scrib.get_height()
	
	has_bomb_box = true
}