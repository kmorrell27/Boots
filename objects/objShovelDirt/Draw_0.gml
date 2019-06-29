draw_sprite_ext(
  sprSmallShadow,
  -1,
  round(x),
  round(y) + 1,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha - 0.375
);
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
