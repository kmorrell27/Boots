if (dying) {
  // We don't care about collisions anymore
  return;
}

if (place_meeting(x + hspeed, y + vspeed, objSolid)) {
  if (hitstun) {
    // This gets tricky
    var aboveBelow = place_meeting(x, y + vspeed, objSolid);
    var sides = place_meeting(x + hspeed, y, objSolid);
    if (aboveBelow && sides) {
      // The wall is above or below
      speed = 0;
    } else if (aboveBelow) {
      direction = direction > 90 && direction < 270 ? 180 : 0;
    } else {
      direction = direction < 180 ? 90 : 270;
    }
  } else {
    direction = (direction + choose(90, 180, 270)) % 360;
  }
}

if (place_meeting(x, y, objSolid)) {
  scr_eject_from_wall();
}
