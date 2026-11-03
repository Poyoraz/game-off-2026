function SpriteNodeArgs() constructor {
	x = 0
	y = 0
	z = 0
	
	wid = 256
	ht = 64

	on_click = noone
	
	use_ref = new UseRef()
	
	starting_frame = 0
	animation_speed = 1
	
	on_update_before = undefined
	on_update_after = undefined
	on_draw_before = sprite_draw_with_size
	on_draw_after = undefined
}

/// @desc  Function Creates a sprite node
/// @param {Asset.Sprite} sprite Content of the sprite
/// @param {struct.SpriteNodeArgs} props Properties
function SpriteNode(
	sprite,
	props = new SpriteNodeArgs()
) : MenuNode(MENU_NODE_TYPES.SPRITE) constructor {
	self.sprite = sprite
	
	static X_HASH = variable_get_hash("x")
	x = struct_get_existing_from_hash(props, X_HASH, 0)
	static Y_HASH = variable_get_hash("y")
	y = struct_get_existing_from_hash(props, Y_HASH, 0)
	static Z_HASH = variable_get_hash("z")
	z = struct_get_existing_from_hash(props, Z_HASH, 0)
	
	pos = new Vector3(x, y, z)
	
	static WID_HASH = variable_get_hash("wid")
	wid = struct_get_existing_from_hash(props, WID_HASH, 256)
	static HT_HASH = variable_get_hash("ht")
	ht = struct_get_existing_from_hash(props, HT_HASH, 64)
	
	static ON_CLICK_HASH = variable_get_hash("on_click")
	_inner_on_click = struct_get_existing_from_hash(props, ON_CLICK_HASH, noone)
	
	on_click = get_on_click_with_loading()
	
	static USE_REF_HASH = variable_get_hash("use_ref")
	use_ref = struct_get_existing_from_hash(props, USE_REF_HASH, new UseRef())
	
	static STARTING_FRAME_HASH = variable_get_hash("starting_frame")
	starting_frame = struct_get_existing_from_hash(props, STARTING_FRAME_HASH, 0)
	static ANIMATION_SPEED_HASH = variable_get_hash("animation_speed")
	animation_speed = struct_get_existing_from_hash(props, ANIMATION_SPEED_HASH, 1)
	
	static UPDATE_BEFORE_HASH = variable_get_hash("on_update_before")
	on_update_before = struct_get_existing_from_hash(props, UPDATE_BEFORE_HASH)
	static UPDATE_AFTER_HASH = variable_get_hash("on_update_after")
	on_update_after = struct_get_existing_from_hash(props, UPDATE_AFTER_HASH)
	static DRAW_BEFORE_HASH = variable_get_hash("on_draw_before")
	on_draw_before = struct_get_existing_from_hash(props, DRAW_BEFORE_HASH, sprite_draw_with_size)
	static DRAW_AFTER_HASH = variable_get_hash("on_draw_after")
	on_draw_after = struct_get_existing_from_hash(props, DRAW_AFTER_HASH)
	
	static predict_wid = _predict_wid
	
	static predict_ht = _predict_ht
	
	static refresh_size = _refresh_size
	
	static resize = _resize
	
	static render = function(Major, parent = noone) {
		var size = new Vector2(
			resolve_size(wid, parent),
			resolve_size(ht, parent, true)
		)
		
		var spr = Major.SpriteCreate(
			pos,
			sprite,
			starting_frame,
			animation_speed,
			parent,
			on_click,
			on_update_before, 
			on_update_after, 
			on_draw_before, 
			on_draw_after
		)
		
		Major.CanvasSetSize(spr, size)
		
		use_ref.setup(spr)
		
		return spr
	}
}

function sprite_draw_with_size(fm_sprite) {
	var size = CanvasGetSize(fm_sprite)
	
	draw_sprite_stretched(
		ElementGetProperty(fm_sprite, "mSprite"),
		ElementGetProperty(fm_sprite, "mIndex"),
		0,
		0,
		size.x,
		size.y
	)
}