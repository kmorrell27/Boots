var shieldDrawn = false;
var img = floor(image_index);

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
shader_set_uniform_f(shader, active ? 0 : 0.5);

if (
  shieldSprite != noone &&
  ((!defend &&
    (dir == Direction.LEFT ||
      (dir == Direction.DOWN && img >= 1 && img <= 3) ||
      (dir == Direction.UP && img >= 5 && img <= 7))) ||
    (defend && dir != Direction.DOWN))
) {
  //Draw the shield sprite.
  draw_sprite_ext(
    shieldSprite,
    -1,
    round(x) + xoff,
    round(y) + yoff + z,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha
  );
  shieldDrawn = true; //Flag as having already drawn the shield.
}

//Draw the player's sprite.
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

//If the shield hasn't been drawn yet...
if (!shieldDrawn && shieldSprite != noone) {
  //Draw the shield sprite.
  draw_sprite_ext(
    shieldSprite,
    -1,
    round(x) + xoff,
    round(y) + yoff + z,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha
  );
}

shader_reset();
