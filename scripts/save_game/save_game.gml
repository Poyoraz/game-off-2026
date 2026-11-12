#macro SAVE_FILE_NAME "save.file"

function save_game(){
	try {
		var file = file_text_open_write(SAVE_FILE_NAME)
	
		file_text_write_string(
			file, 
			json_stringify(SaveHandler.file.export_save())
		)
	
	} catch(e) {
		show_debug_message(e)
	}
}