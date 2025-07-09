function scr_run_button_pressed() {
  return gamepad_is_connected(0)
    ? gamepad_button_check_pressed(0, gp_shoulderl)
    : keyboard_check_pressed(ord("D"));
}
