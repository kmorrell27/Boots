function scr_add_hspeed(argument0, isRunDir) {
  /*********************************************************************
	This script adds to (or substracts from) the player's horizontal speed, with
	respect to their speed cap.

	format:  scr_add_hspeed(amount);
	*********************************************************************/

  var _max = isRunDir ? maxspd * 2 : maxspd;
  if (argument0 > 0) {
    if (hspeed + argument0 <= _max) {
      hspeed += argument0;
    } else {
      hspeed = _max;
    }
  } else {
    if (hspeed + argument0 >= -_max) {
      hspeed += argument0;
    } else {
      hspeed = -_max;
    }
  }
}
