if (partySize == 1) {
  audio_play_sound(sndError, 10, false);
  return;
}

// party: 15
// newParty: 7
// partySize: 1
// newPartySize = 3
// party: 8

var newPlayer = instance_create_depth(x, y, depth - 1, objPlayer);

active = false;

newPlayer.active = true;
newPlayer.party = party - global.player;
newPlayer.partySize = partySize - 1;

party = global.player;
partySize = 1;

if (newPlayer.party == 1) {
  global.player = 1;
} else if (newPlayer.party <= 3) {
  global.player = 2;
} else if (newPlayer.party <= 7) {
  global.player = 4;
} else {
  global.player = 8;
}

inactiveSprite = sprite_index;
image_index = 0;
