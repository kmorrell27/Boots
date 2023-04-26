if (!hitstun) {
  hitstun = true;
  direction = point_direction(global.playerid.x, global.playerid.y, x, y);
  spd = 3;

  health = max(health - 1, 0);
  if (health == 0) {
    alarm[1] = global.onesecond / 10;
  } else {
    alarm[0] = global.onesecond / 5;
  }
}
