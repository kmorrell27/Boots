//First draw the chest.
draw_sprite_ext(
  sprite_index,
  -1,
  x,
  y,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha
);

//Now, if the chest has been opened and has showtime left, go inside.
if (opened && opentmr) {
  //First draw the shadow of the item over the chest.
  draw_sprite_ext(
    sprSmallShadow,
    -1,
    x + 4,
    y + 3,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha - 0.375
  );
  //Now draw the actual item.
  draw_sprite_ext(
    itemspr,
    -1,
    x + 8,
    y + drawy,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    itemalpha
  );
}
