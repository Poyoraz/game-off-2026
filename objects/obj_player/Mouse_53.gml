var _dir = point_direction(x, y, mouse_x, mouse_y)

var hook = instance_create_depth(x, y, depth - 1, obj_hook, {
})

hook.speed = 25
hook.direction = _dir
hook.image_angle = _dir