return gamepad_is_connected(0) ? gamepad_button_check_released(0, gp_face3) : keyboard_check_released(ord("A"));
