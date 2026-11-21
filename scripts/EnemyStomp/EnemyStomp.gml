function EnemyStomp() : EnemyWeapon() constructor{
	cooldown = 400
	range = 800

	static tick = function(enemy) {
		cooldown--
			
		if(cooldown < 0) {
			var colliding_list = ds_list_create()
	
			var _precollide_count = collision_line_list(
				enemy.bbox_left, 
				enemy.bbox_bottom + 1, 
				enemy.bbox_right, 
				enemy.bbox_bottom + 1,
				obj_collidable, false, true,
				colliding_list,
				false
			)
	
			var _precollide_list = ds_list_to_array(colliding_list)
			ds_list_destroy(colliding_list)
	
			for (var i = 0; i < _precollide_count; ++i) {
			    var _item = _precollide_list[i]
		
				_item.transmit_momentum(120, true, TransmitMomentumType.SHOCKWAVE)
			}
	
			array_push(_precollide_list, enemy.id)
	
			for (var i = 0; i < 2; ++i) {
			    var _dir =  i * 180
		
				instance_create_depth(
					enemy.x,
					enemy.bbox_bottom - 1,
					enemy.depth - 1,
					obj_shockwave,
					{
						direction: _dir,
						initial_items: _precollide_list
					}
				)
			}
				
			cooldown = 400
		}
	}

}