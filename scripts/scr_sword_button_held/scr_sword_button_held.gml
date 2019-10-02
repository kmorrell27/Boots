return gamepad_is_connected(0)
  ? gamepad_button_check(0, gp_face3)
  : keyboard_check(ord("A"));
