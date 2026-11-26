event_inherited()

has_bomb_box = false

scrib = scribble("[fnt_large]Bring the Bomb Box Here")
	.wrap(240)
	.starting_format("fnt_main", c_black)

box_width = scrib.get_width()
box_height = scrib.get_height()

interact = function(this) {
	if(!this.has_bomb_box) return;
	if(instance_exists(obj_bomb)) return;
	
	var _block = instance_create_depth(x, y + 128, obj_player.depth - 1, obj_bomb)
		
	obj_player.set_bash(_block, true)
}