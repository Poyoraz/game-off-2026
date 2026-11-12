function MainMenu() : BaseRoom() constructor{
	page = new RowNode([
		new ColNode([
			new ButtonNode("New Game", {
				on_click: function() {
					room_goto(room_ground_test)
				}
			}),
			new ButtonNode("Load Game", {
				on_click: function() {
					room_goto(SaveHandler.file.current_level)
				}
			}),
			new ButtonNode("Exit", {
				on_click: function() {
					game_end()
				}
			}),
		], {
			v_gap: 16
		})
	])
}