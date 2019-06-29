//If Link hasn't picked up the item yet, it should draw a shadow.
if (!got) {
  draw_sprite_ext(
    sprSmallShadow,
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
//Then draw the sprite of the item itself.
draw_sprite_ext(
  sprite_index,
  -1,
  round(x) + 4,
  round(y) + z,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha
);
