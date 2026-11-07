function position_in_room(_x, _y){
	if(_x < 0) return false;
	if(_y < 0) return false;
	if(_x > room_width) return false;
	if(_y > room_height) return false;
	
	return true
}