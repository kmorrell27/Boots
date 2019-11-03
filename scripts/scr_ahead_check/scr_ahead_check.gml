///@arg obj
///@arg distance

/*
This script checks to see if the object passed as a parameter is
directly in front of the player, depending on which direction he's facing.
Returns the id of the object if so, -1 otherwise.
format:  scr_ahead_check(object, distance);
*/

if (dir == Direction.DOWN && place_meeting(x, y + argument1, argument0)) {
  return instance_place(x, y + argument1, argument0);
} else if (dir == Direction.UP && place_meeting(x, y - argument1, argument0)) {
  return instance_place(x, y - argument1, argument0);
} else if (
  dir == Direction.LEFT &&
  place_meeting(x - argument1, y, argument0)
) {
  return instance_place(x - argument1, y, argument0);
} else if (
  dir == Direction.RIGHT &&
  place_meeting(x + argument1, y, argument0)
) {
  return instance_place(x + argument1, y, argument0);
}

return -1;
