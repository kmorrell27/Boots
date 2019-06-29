/*******************************************************************
This script adjusts how much Link is healing or taking damage
based on the parameter.  Negative paramaters indicate damage,
positive parameters indicate healing.

format:  scr_heal(amount);
*******************************************************************/

global.heal += argument0;

if (global.heal + global.hearts < 0) {
  global.heal = 0 - global.hearts;
}
if (global.heal + global.hearts > global.heartmax) {
  global.heal = global.heartmax - global.hearts;
}
