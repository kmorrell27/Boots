if (o_input.up_pressed_) {
	index_ = max(--index_, 0);
}
if (o_input.down_pressed_) {
	index_ = min(++index_, option_length_ - 1);
}
if (o_input.action_one_pressed_) {
	switch (index_) {
		case TitleOptions.CONTINUE_GAME:
			break;
		case TitleOptions.NEW_GAME:
			room_goto(r_world);
			break;
		case TitleOptions.CREDITS:
			break;
		case TitleOptions.QUIT:
			game_end();
			break;
		default:
			show_debug_message("Wuh-oh");
			break;
	}
}