function scr_up_button_pressed() {
  return gamepad_is_connected(0)
    ? gamepad_button_check_pressed(0, gp_padu) ||
        (!isMoving && gamepad_axis_value(0, gp_axislv) < 0)
    : keyboard_check_pressed(vk_up);
}
