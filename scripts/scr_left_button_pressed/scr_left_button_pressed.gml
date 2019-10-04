return gamepad_is_connected(0)
  ? (gamepad_button_check_pressed(0, gp_padl) || (!isMoving && gamepad_axis_value(0, gp_axislh) < 0))
  : keyboard_check_pressed(vk_left);
