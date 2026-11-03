Major.Free()
menu_object.unload()

array_foreach(modals, function(_item) {
	_item.unload()
})

delete Major