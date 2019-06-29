/*********************************************************************
This script adds to (or substracts from) Link's horizontal speed, with
respect to his speed cap.

format:  scr_link_add_hspeed(amount);
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
