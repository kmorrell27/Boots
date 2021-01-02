function scr_shield_button_pressed() {
  return gamepad_is_connected(0)
    ? gamepad_button_check_pressed(0, gp_shoulderr) ||
        gamepad_button_check_pressed(0, gp_shoulderrb)
    : keyboard_check_pressed(ord("C"));
}
