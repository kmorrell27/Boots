/*********************************************************************
This script adds to (or substracts from) the player's vertical speed, with
respect to their speed cap.

format:  scr_add_vspeed(amount);
*********************************************************************/

if (argument0 > 0) {
  if (vspeed + argument0 <= maxspd) {
    vspeed += argument0;
  } else {
    vspeed = maxspd;
  }
} else {
  if (vspeed + argument0 >= -maxspd) {
    vspeed += argument0;
  } else {
    vspeed = -maxspd;
  }
}
