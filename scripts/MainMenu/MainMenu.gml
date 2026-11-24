global.SEND_TO_CHECKPOINT = false

function MainMenu() : BaseRoom() constructor{
	page = new RowNode([
		new ColNode([
			new ButtonNode("New Game", {
				on_click: function() {
					global.persistent_player_data = new PersistentPlayerData()
					
					room_goto(lvl1)
				}
			}),
			new ButtonNode("Load Game", {
				on_click: function() {
					global.SEND_TO_CHECKPOINT = true
					global.persistent_player_data = new PersistentPlayerData()
					
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