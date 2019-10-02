/*********************************************************************
This script draws the HUD.

format:  scr_draw_hud(xpos,ypos);
*********************************************************************/

//If a text box is covering the HUD, hide it.
if (instance_exists(objTextBox) && objTextBox.pos == Direction.DOWN) {
  exit;
}

/*
Temporary variable for the y offset of where to draw the hud, based
on the anchor.  If it's negative, then it'll start from the bottom.
Otherwise, it'll start from the top.
*/
var yoff = 128;

//Temporary variable for what color blend to use for a HUD elemnt.
var blend = Color.WHITE;

//Next, draw the Rupee icon, based on which wallet Link has.
draw_sprite_ext(
  sprRupeeIcon,
  global.wallet,
  argument0 + 8,
  argument1 + yoff,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  1
);
//If Link has no rupees, the digits should be gray.
if (global.rupees == 0) {
  blend = Color.GRAY;
} else if (global.rupees == global.rupeemax[global.wallet]) {
  /*
    If Link has the max rupees he can carry, the digits should
    be yellow.
    */
  blend = Color.YELLOW;
} else {
  /*
    Otherwise, just use plain white digits.
    */
  blend = Color.WHITE;
}
//Now draw the counter for the rupees.
scr_draw_counter(global.rupees, 3, argument0, argument1 + yoff + 8, blend, 1);

blend = global.heartblend; //Set the blend to what the hearts need.
//Now draw the hearts.
scr_draw_hearts(
  global.hearts,
  global.heartmax,
  7,
  argument0 + 24,
  argument1 + yoff,
  blend,
  1
);
