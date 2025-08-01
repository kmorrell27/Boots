//If the game is paused, get out of here.
if (scr_pause_check()) {
  exit;
}

/*
If the player is jumping down a cliff and they're still not at a free space,
do what's in here.
*/
if (cliff && !place_free(x, y)) {
  /*
    Move forward, depending on which way the player is jumping down a
    cliff.
    */
  if (cliffdir == Direction.DOWN) {
    y += cliffspd;
  } else if (cliffdir == Direction.UP) {
    y -= cliffspd;
  } else if (cliffdir == Direction.LEFT) {
    x -= cliffspd;
  } else {
    x += cliffspd;
  }
} else {
  cliffspd = 2;
  //Reset the cliff jumping speed.
}

//Get the camera moving to where it needs to be.
scr_align_camera(false);
