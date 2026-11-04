bottom_collision = place_meeting(x, y + 2, obj_collidable)
top_collision = place_meeting(x, y - 2, obj_collidable)
left_collision = place_meeting(x - 2, y, obj_collidable)
right_collision = place_meeting(x + 2, y, obj_collidable)

if(bottom_collision && vertical_speed > 0) {
	vertical_speed = 0
}
if(top_collision && vertical_speed < 0) {
	vertical_speed = 0
}
if(left_collision && horizontal_speed < 0) {
	horizontal_speed = 0
}
if(right_collision && horizontal_speed > 0) {
	horizontal_speed = 0
}