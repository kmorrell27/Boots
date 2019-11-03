/*
Draw the shadow below Link's sprite, 1 pixel further down, if he's
not in a sideview area.
*/
if (!global.sideview) {
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
shader_set(sh_saturation);
shader_set_uniform_f(shader, active ? 0 : 0.7);
//Draw Link's sprite.
draw_sprite_ext(
  sprite_index,
  -1,
  round(x) + xoff,
  round(y) + yoff + z,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  image_alpha
);
shader_reset();
