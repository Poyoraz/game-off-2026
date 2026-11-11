// Inherit the parent event
event_inherited();

scrib = scribble(text).wrap(max_wid).starting_format("fnt_main", c_black)
typist = scribble_typist()

typist.in(1, 0)

box_width = scrib.get_width()
box_height = scrib.get_height()

on_enter = method(self, function(){
	typist.reset()
})

alpha = 0