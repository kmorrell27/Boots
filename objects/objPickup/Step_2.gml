//If the item goes off the bounds of the room, bring it back in.
if (x < 0) {
  x = 0;
}
if (y < 0) {
  y = 0;
}
if (x + sprite_width > room_width) {
  x = room_width - sprite_width;
}
if (y + sprite_height > room_height) {
  y = room_height - sprite_height;
}
