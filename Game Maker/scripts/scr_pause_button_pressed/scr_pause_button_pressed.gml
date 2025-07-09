function scr_pause_button_pressed() {
  return gamepad_is_connected(0)
    ? gamepad_button_check_pressed(0, gp_start)
    : keyboard_check_pressed(vk_enter);
}
