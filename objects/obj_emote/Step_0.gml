timer += 1;
if (mode == 0) {
  if (timer > room_speed / 2) {
    image_alpha -= 0.1;
    if (image_alpha <= 0) instance_destroy();
  }

  if (instance_exists(creator)) {
    x = creator.x;
    y = creator.y - creator.sprite_height;
  }
} else if (mode == 1) {
  if (scr_bomb_button_pressed()) {
    fade = true;
  }
  if (fade) {
    image_alpha -= 0.1;
    if (image_alpha <= 0) instance_destroy();
  }
}
