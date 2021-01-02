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

// Draw my backup peeps
var offset = (stepIndex + 80) % 96;
for (var i = 0; i < 4; i++) {
  if (power(2, i) == global.player) {
    offset = (offset + 80) % 96;
    continue;
  }

  if (x == xPos[offset] && y == yPos[offset] && zPos[offset] == z) {
    offset = (offset + 80) % 96;
    continue;
  }

  var spr = global.sprites[i][dirHistory[offset]];
  draw_sprite_ext(
    spr,
    -1,
    round(xPos[offset]),
    round(yPos[offset]) + zPos[offset],
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha
  );

  offset = (offset + 80) % 96;
}
