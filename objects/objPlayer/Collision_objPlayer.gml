/// @description Insert description here
// You can write your code in this editor

if (!canMerge || !other.canMerge || !active) {
  // The active one can recombine
  return;
}

if (persistent) {
  // It's important that everything folds into this one
  partySize += other.partySize;
  party += other.party;
  other.canMerge = false;
  instance_destroy(other);
} else {
  // We don't really care what happens here
  other.partySize += partySize;
  other.party += party;
  global.playerid = other.id;
  other.active = true;
  canMerge = false;
  instance_destroy();
}
