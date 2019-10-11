if (!hitstun) {
  hitstun = true;
  direction = point_direction(objPlayer.x, objPlayer.y, x, y);
  speed = 3;
  alarm[0] = global.onesecond / 5;
}