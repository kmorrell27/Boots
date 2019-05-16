if (place_meeting(x, y, o_player)) {
	if (x_ != -1) { o_player.x = x_; }
	if (y_ != -1) { o_player.y = y_; }
    
	RoomTransition(room_, kind_, 60);
}