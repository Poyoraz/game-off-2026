var colliding = place_meeting(x, y, obj_player) 

if(colliding && !entered) {
	entered = true
	
	on_enter(self)
} else if(!colliding && entered){
	entered = false

	on_leave(self)
}