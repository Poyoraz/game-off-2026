function load_game(){
	var _val

	try {
		var _file = file_text_open_read(SAVE_FILE_NAME)
	
		var _str = file_text_read_string(_file)
		
		_val = json_parse(_str)
	} catch(e) {
		show_debug_message(e)
		
		_val = {}
	}
	
	SaveHandler.file = new SaveFile(_val)
}