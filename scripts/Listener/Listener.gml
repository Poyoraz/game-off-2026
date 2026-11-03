global.listeners = ds_map_create()

function Listener(callback) constructor {
	self.callback = callback
}