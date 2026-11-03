function push_modal(element){
	array_push(
		obj_menu.modals,
		element
	)
	
	element.page.render(obj_menu.Major, global.MAJORGUI_MAIN_CANVAS)
}