if(controls_disabled) exit

if(instance_exists(obj_hook)) {
	if(obj_hook.grappled) {
		warp(obj_hook.x, obj_hook.y, true)
	
		instance_destroy(obj_hook)
	
		return;
	}
}

if(dash_cooldown > 0) {
	return;
}

var held_right = keyboard_check(ord("D")),
	held_left = keyboard_check(ord("A")),
	held_up = keyboard_check(ord("W")),
	held_down = keyboard_check(ord("S"))
		
var _dir = get_angle_from_input(
	held_right - held_left,
	held_down - held_up
)

if(_dir == 0 && facing_left) {
	_dir = 180
}

facing_left = ((_dir + 450) mod 360 > 180)

dash(_dir)