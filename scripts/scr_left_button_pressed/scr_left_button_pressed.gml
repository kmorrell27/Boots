return gamepad_is_connected(0)
  ? gamepad_button_check_pressed(0, gp_padl)
  : keyboard_check_pressed(vk_left);
