var mainmenu = new MainMenu()

instance_create_depth(
	room_width / 2,
	room_height / 2,
	0,
	obj_menu,
	{
		menu_object: mainmenu
	}
)