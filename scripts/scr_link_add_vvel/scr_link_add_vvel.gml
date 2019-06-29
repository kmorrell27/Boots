/*********************************************************************
This script adds to (or substracts from) Link's conserved vertical
force, with respect to 0.

format:  scr_link_add_vvel(amount);
*********************************************************************/

if (argument0 > 0 && vvel < 0) {
  vvel += argument0;
  if (vvel > 0) {
    vvel = 0;
  }
} else if (argument0 < 0 && vvel > 0) {
  vvel += argument0;
  if (vvel < 0) {
    vvel = 0;
  }
}
