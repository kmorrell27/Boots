if (dying) {
  // We don't care about collisions anymore
  spd = 0;
  return;
}

move_contact_solid(direction, 1);
move_outside_solid((direction + 180) % 360, 1);

var hspd = lengthdir_x(1, direction);
var vspd = lengthdir_y(1, direction);
if (place_meeting(x + hspd, y + vspd, objSolid)) {
  if (hitstun) {
    // This gets tricky
    var aboveBelow = place_meeting(x, y + vspd, objSolid);
    var sides = place_meeting(x + hspd, y, objSolid);
    if (aboveBelow && sides) {
      // The wall is above or below
      spd = 0;
    } else if (aboveBelow) {
      direction = direction > 90 && direction < 270 ? 180 : 0;
    } else {
      direction = direction < 180 ? 90 : 270;
    }
  } else {
    direction = (direction + choose(90, 180, 270)) % 360;
  }
}
