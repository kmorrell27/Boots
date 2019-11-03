/*********************************************************************
This script adds to (or substracts from) the player's conserved horizontal
force, with respect to 0.

format:  scr_add_hvel(amount);
*********************************************************************/

if (argument0 > 0 && hvel < 0) {
  hvel += argument0;
  if (hvel > 0) {
    hvel = 0;
  }
} else if (argument0 < 0 && hvel > 0) {
  hvel += argument0;
  if (hvel < 0) {
    hvel = 0;
  }
}
