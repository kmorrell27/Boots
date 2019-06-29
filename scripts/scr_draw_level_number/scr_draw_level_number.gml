/*********************************************************************
This script draws the level number of something at the given position.

format:  scr_draw_level_number(value,xpos,ypos,blend,alpha);
*********************************************************************/

/*
First, draw the Level indicator. Then draw the actual number.
*/
draw_sprite_ext(
  sprHUDLevel,
  -1,
  argument1,
  argument2,
  image_xscale,
  image_yscale,
  image_angle,
  argument3,
  argument4
);
draw_sprite_ext(
  sprHUDDigits,
  real(argument0),
  argument1 + 8,
  argument2,
  image_xscale,
  image_yscale,
  image_angle,
  argument3,
  argument4
);
