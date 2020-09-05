//Temporary variable for the image of animation.
var imgchk = floor(image_index);

/*
If the hammering animation hasn't just started and isn't at the end,
then draw a ghost at the last X and Y offset.
*/
if (imgchk > 0 && imgchk < 3) {
  draw_sprite_ext(
    sprite_index,
    imgchk - 1,
    round(global.playerid.x) + global.playerid.xoff + lastxoff,
    round(global.playerid.y) + global.playerid.yoff + lastyoff + z,
    image_xscale,
    image_yscale,
    image_angle,
    Color.BLACK,
    image_alpha - 0.625
  );
}

//Now draw the hammer itself.
draw_sprite_ext(
  sprite_index,
  -1,
  round(x),
  round(y) + z,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha
);
