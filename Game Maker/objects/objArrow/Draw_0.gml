//Draw the ghost of the arrow first.
draw_sprite_ext(
  sprite_index,
  -1,
  round(xprevious),
  round(yprevious),
  image_xscale,
  image_yscale,
  image_angle,
  Color.BLACK,
  image_alpha - 0.5
);
//Then draw the actual arrow.
draw_sprite_ext(
  sprite_index,
  -1,
  round(x),
  round(y),
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha
);
