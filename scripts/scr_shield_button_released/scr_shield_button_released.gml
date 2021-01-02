function scr_shield_button_released() {
  return gamepad_is_connected(0)
    ? gamepad_button_check_released(0, gp_shoulderr) ||
        gamepad_button_check_released(0, gp_shoulderrb)
    : keyboard_check_released(ord("C"));
}
