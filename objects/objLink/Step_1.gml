//If the game is paused, get out of here.
if (scr_pause_chk()) {
  exit;
}

/*
If Link is jumping down a cliff and he's still not at a free space,
do what's in here.
*/
if (cliff && !place_free(x, y)) {
  /*
    Move forward, depending on which way Link is jumping down a
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
scr_align_view(false);
