//If the beam goes off of the screen, delete it.
if (
  x + sprite_width < 0 ||
  x > room_width ||
  y + sprite_height < 0 ||
  y > room_height
) {
  instance_destroy();
}
