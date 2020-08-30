function scr_player_sprite_change() {
  // This might just work? We'll see.

  var result = -1;
  var tmp = global.player;
  while (tmp > 0) {
    result++;
    tmp = tmp >> 1;
  }

  var player = global.sprites[result];

  switch (dir) {
    case 1:
      sprite_index = player[0];
      break;
    case 2:
      sprite_index = player[1];
      break;
    case 4:
      sprite_index = player[2];
      break;
    case 8:
      sprite_index = player[3];
      break;
  }
}
