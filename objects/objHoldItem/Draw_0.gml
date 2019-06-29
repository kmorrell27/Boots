//If Link hasn't picked this up yet, draw a shadow under it.
if (!got) {
  draw_sprite_ext(
    sprShadow,
    -1,
    x,
    y + 1,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha - 0.125
  );
}

//Now draw the sprite of the item.
draw_sprite_ext(
  sprite_index,
  -1,
  x + 8,
  y + 8 + drawy,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha
);
