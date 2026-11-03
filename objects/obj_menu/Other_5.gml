Major.Free()
menu_object.unload()
array_foreach(modals, function(_item) {
	_item.unload()
})

if(room_persistent) queued_for_rerender_on_room_enter = true
else delete Major