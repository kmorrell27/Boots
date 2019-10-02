return gamepad_is_connected(0) ? gamepad_button_check_released(0, gp_face4) : keyboard_check_released(ord("S"));
