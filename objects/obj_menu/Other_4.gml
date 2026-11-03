if(queued_for_rerender_on_room_enter) {
	Major.Setup(screen_size)
	
	menu_object.page.render(Major, global.MAJORGUI_MAIN_CANVAS)
	
	queued_for_rerender_on_room_enter = false
	
	array_foreach(modals, function(_item) {
		_item.page.render(obj_menu.Major, global.MAJORGUI_MAIN_CANVAS)
	})
}