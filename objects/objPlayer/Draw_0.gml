/*
Draw the shadow below the player's sprite, 1 pixel further down, if they're
not in a sideview area.
*/
var shieldDrawn = false;

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

/*
If Link isn't defending, the shield should be drawn under him
only if he's facing left.  Otherwise, it should be under him if he's
facing Left, Up or Right.
*/
if (
  shieldSprite != noone &&
  ((!shielding &&
    (dir == Direction.LEFT ||
      (dir == Direction.DOWN && img >= 1 && img <= 3) ||
      (dir == Direction.UP && img >= 5 && img <= 7))) ||
    (shielding && dir != Direction.DOWN))
) {
  //Draw the shield sprite.
  draw_sprite_ext(
    shieldspr,
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
