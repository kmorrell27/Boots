// This might just work? We'll see.

var result = -1;
var tmp = global.player;
while (tmp > 0) {
  result++;
  tmp = tmp >> 1;
}

var player = global.sprites[result];
sprite_index = player[dir];
