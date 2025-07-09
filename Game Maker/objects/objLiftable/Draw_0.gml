/*
Draw the shadow below the item's sprite if it's mid-throw
*/
if (thrown) {
  draw_sprite_ext(
    sprShadow,
    -1,
    round(x),
    round(y) + 1,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha - 0.125
  );
}

//Draw the items's sprite.
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
