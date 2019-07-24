/*
Temporary variables for having drawn the shield or not, and Link's
current frame of animation.
*/
var drewshield = false;
var img = floor(image_index);

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

/*
If Link isn't defending, the shield should be drawn under him
only if he's facing left.  Otherwise, it should be under him if he's
facing Left, Up or Right.
*/
if (
  holding != 1 &&
  ((!defend &&
    (dir == Direction.LEFT ||
      (dir == Direction.DOWN && img >= 1 && img <= 3) ||
      (dir == Direction.UP && img >= 5 && img <= 7))) ||
    (defend && dir != Direction.DOWN))
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
  drewshield = true; //Flag as having already drawn the shield.
}

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

//If the shield hasn't been drawn yet...
if (!drewshield) {
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
}
