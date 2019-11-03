/********************************************************************
This script draws hearts based on the given values.  Each heart is
represented by 16, so for example, 3 hearts is 48.  So while current
doesn't necessarily need to be a multiple of 16, max definitely does.

format:  scr_draw_hearts(current,max,maxperrow,xpos,ypos,blend,alpha);
********************************************************************/

/*
First, setup a loop counter.  Each increment represents a whole
heart container.  Also, set up a tracker of which row the loop is
drawing.  Lastly, setup a variable for which blend to use.
*/
var i = 0;
var row = 0;
var color = Color.WHITE;

//Next, figure out how many iterations of the loop we'll need.
var imax = floor(argument1 / 16);

/*
Setup variables for which sprite to use, and which image to use.
*/
var spr = sprActiveHeart;
var img = -1;

//Now start looping.
for (i = 0; i < imax; i += 1) {
  /*
    If the counter is on the heart that is the last on the row,
    then it should have 1 added to which row it is on.
    */
  if ((i + 1) % (argument2 + 1) == 0) {
    row++;
  }

  /*
    If the counter is on some heart before the current value is at,
    then the sprite should be a small full container, and the img -1
    for any image, incase you want that to animate.  The blend should
    be white, for no blending.
    */
  if (argument0 > (i + 1) * 16) {
    spr = sprFullHeart;
    img = -1;
    color = Color.WHITE;
  } else if (argument0 <= i * 16) {
    /*
        Otherwise, if the counter is on some heart after the current
        value is at, then the sprite should be a small empty container,
        and the img -1 for any image, incase you want that to animate.
        The blend should be the parameter.
        */
    spr = sprEmptyHeart;
    img = -1;
    color = argument5;
  } else {
    /*
        Otherwise, the sprite should be the active heart sprite, and
        the image set to a specific subimage, based on how much
        health the player has left.  The blend should be white, for no
        blending.
        */
    spr = sprActiveHeart;
    img = 4 - round(((argument0 - 16 * i) / 16) * 4);
    color = Color.WHITE;
  }

  /*
    Now draw the heart sprite with at the given position with
    the given formatting.
    */

  draw_sprite_ext(
    spr,
    img,
    argument3 + (i - row * argument2) * 8,
    argument4 + 8 * row,
    image_xscale,
    image_yscale,
    image_angle,
    color,
    argument6
  );
}
