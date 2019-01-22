enum TitleOptions {
	CONTINUE_GAME,
	NEW_GAME,
	CREDITS,
	QUIT
}

menu_color_ = make_color_rgb(247, 243, 143);
menu_dark_color_ = make_color_rgb(126, 127, 81);


option_ = ["Continue",
		   "New Game",
		   "Credits",
		   "Quit"];

option_length_ = array_length_1d(option_);

index_ = TitleOptions.CONTINUE_GAME;