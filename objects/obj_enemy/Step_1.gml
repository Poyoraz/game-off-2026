// Inherit the parent event
event_inherited();

var too_close = abs(obj_player.x - self.x) - social_distancing

move_dir = sign(obj_player.x - self.x)

if (too_close < 0) {
	move_dir *= -1;	
}

if(obj_player.x < x - social_distancing) {
	move_dir = -1
} else if(obj_player.x > x + social_distancing) {
	move_dir = 1
}

if(move_dir = 0 && instance_exists(collision_line(x,bbox_top,x,y+400,obj_collidable,false,true))) {
	random_range(-1,1)
}