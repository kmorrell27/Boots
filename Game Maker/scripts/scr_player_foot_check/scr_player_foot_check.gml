function scr_player_foot_check(argument0) {
  /*******************************************************************
	This script checks to see if the parameter is met at the
	center of the player's feet.
	format:  scr_player_foot_check(object);
	********************************************************************/

  return collision_line(x + 6, y + 14, x + 8, y + 14, argument0, true, false);
}
