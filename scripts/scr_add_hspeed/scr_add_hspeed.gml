function scr_add_hspeed(argument0) {
  /*********************************************************************
	This script adds to (or substracts from) the player's horizontal speed, with
	respect to their speed cap.

	format:  scr_add_hspeed(amount);
	*********************************************************************/

  if (argument0 > 0) {
    if (hspeed + argument0 <= maxspd) {
      hspeed += argument0;
    } else {
      hspeed = maxspd;
    }
  } else {
    if (hspeed + argument0 >= -maxspd) {
      hspeed += argument0;
    } else {
      hspeed = -maxspd;
    }
  }
}
