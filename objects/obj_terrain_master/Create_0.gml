line = array_map(layer_get_all_elements("Instances"), function(element_id) {
  return layer_instance_get_instance(element_id)
})

show_debug_message(line)

curr = 0

_texture = sprite_get_texture(spr_texture, 0)