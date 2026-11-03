for(var _i = 0; _i < queued_unloads; _i++) {
	var element = array_pop(
		modals
	)
	Major.ElementFree(element.page.use_ref.current)
	
	element.unload()
}

queued_unloads = 0