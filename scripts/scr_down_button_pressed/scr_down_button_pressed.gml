return gamepad_is_connected(0)
  ? (gamepad_axis_value(0, gp_axislv) > 0 && !isMoving) ||
      gamepad_button_check_pressed(0, gp_padd)
  : keyboard_check_pressed(vk_down);
