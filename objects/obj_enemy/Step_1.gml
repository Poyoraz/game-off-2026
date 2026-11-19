// Inherit the parent event
event_inherited();

var player_dis = abs(obj_player.x - self.x)
var player_dir = sign(obj_player.x - self.x)

var too_close = player_dis - social_distancing

if ((social_distancing - follow_buffer) < player_dis && player_dis < (social_distancing + follow_buffer)) {
	move_dir = 0;
} else if (too_close < 0) {
	move_dir = -player_dir;	
} else {
	move_dir = player_dir
}
