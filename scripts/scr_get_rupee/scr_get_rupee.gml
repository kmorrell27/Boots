/*******************************************************************
This script adjusts how much Link's wallet is being modified.
Negative parameters means he's losing money.  Positive parameters
means he's gaining money.

format:  scr_get_rupees(amount);
*******************************************************************/

global.rupoff += argument0;

if (global.rupoff + global.rupees < 0) {
  global.rupoff = 0 - global.rupees;
}
if (global.rupoff + global.rupees > global.rupeemax[global.wallet]) {
  global.rupoff = global.rupeemax[global.wallet] - global.rupees;
}
