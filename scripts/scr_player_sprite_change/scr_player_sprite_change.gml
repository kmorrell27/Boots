function scr_player_sprite_change() {
  // This might just work? We'll see.

  var result = -1;
  var tmp = global.player;
  while (tmp > 0) {
    result++;
    tmp = tmp >> 1;
  }

  var player = global.sprites[result];
  sprite_index = player[dir];

  if (global.player == Character.HAROLD) {
    // oh geeze we have shield logic
    if (!isMoving) {
      if (!defend) {
        switch (dir) {
          case Direction.LEFT:
            shieldSprite = sprShield1IL;
            break;
          case Direction.UP:
            shieldSprite = sprShield1IU;
            break;
          case Direction.RIGHT:
            shieldSprite = sprShield1IR;
            break;
          case Direction.DOWN:
            shieldSprite = sprShield1ID;
            break;
        }
      } else {
        switch (dir) {
          case Direction.UP:
            shieldSprite = sprShield1UIU;
            break;
          case Direction.RIGHT:
            shieldSprite = sprShield1UIR;
            break;
          case Direction.DOWN:
            shieldSprite = sprShield1UID;
            break;
          case Direction.LEFT:
            shieldSprite = sprShield1UIL;
            break;
        }
      }
    } else {
      if (!defend) {
        switch (dir) {
          case Direction.UP:
            shieldSprite = sprShield1WU;
            break;
          case Direction.RIGHT:
            shieldSprite = sprShield1WR;
            break;
          case Direction.DOWN:
            shieldSprite = sprShield1WD;
            break;
          case Direction.LEFT:
            shieldSprite = sprShield1WL;
            break;
        }
      } else {
        switch (dir) {
          case Direction.UP:
            shieldSprite = sprShield1UU;
            break;
          case Direction.RIGHT:
            shieldSprite = sprShield1UR;
            break;
          case Direction.DOWN:
            shieldSprite = sprShield1UD;
            break;
          case Direction.LEFT:
            shieldSprite = sprShield1UL;
            break;
        }
      }
    }
  } else {
    shieldSprite = noone;
  }
}
