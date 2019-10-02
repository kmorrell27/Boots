return gamepad_is_connected(0)
  ? gamepad_button_check_pressed(0, gp_face4)
  : keyboard_check_pressed(ord("S"));
