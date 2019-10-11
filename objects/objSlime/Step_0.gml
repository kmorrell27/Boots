if (place_meeting(x + hspeed, y + vspeed, objWall)) {
  if (hitstun) {
	// This gets tricky
	var aboveBelow = place_meeting(x, y + vspeed, objWall);
	var sides = place_meeting(x + hspeed, y, objWall);
	if (aboveBelow && sides) {
	  // The wall is above or below
	  speed = 0;
	} else if (aboveBelow) {
	  direction = (direction > 90 && direction < 270) ? 180 : 0;
	} else {
	  direction = (direction < 180) ? 90 : 270;
	}
  } else {
    direction = (direction + choose(90, 180, 270)) % 360;
  }
}