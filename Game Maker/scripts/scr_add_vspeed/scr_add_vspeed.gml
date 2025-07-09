function scr_add_vspeed(argument0, isRunDir) {
  /*********************************************************************
	This script adds to (or substracts from) the player's vertical speed, with
	respect to their speed cap.

	format:  scr_add_vspeed(amount);
	*********************************************************************/

  var _max = isRunDir ? maxspd * 2 : maxspd;
  if (argument0 > 0) {
    if (vspeed + argument0 <= _max) {
      vspeed += argument0;
    } else {
      vspeed = _max;
    }
  } else {
    if (vspeed + argument0 >= -_max) {
      vspeed += argument0;
    } else {
      vspeed = -_max;
    }
  }
}
