function scr_bomb_button_pressed() {
  return gamepad_is_connected(0)
    ? gamepad_button_check_pressed(0, gp_face2)
    : keyboard_check_pressed(ord("X"));
}
