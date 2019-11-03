/********************************************************************
This script just checks for double tapping in the same direction as
the argument.  It was made into the script since it was written 4
times, originally.

format:  scr_doubletap(direction as a Direction enum);
********************************************************************/

//If the double tap direction check wasn't for the given direction...
if (doublekeytapdir != argument0) {
  //Make the double tap directional check for the given direction.
  doublekeytapdir = argument0;
  //Give the player twenty frames to tap it again.
  doublekeytapdly = global.onesecond / 3;
} else if (doublekeytapdly && dir == doublekeytapdir) {
  /*
    Otherwise, if it's pressed again within the checking interval,
    and the player is facing in the right direction, prepare the player for
    some rolling action.
    */
  tempcanroll = true;
}
