//If the game is paused, get out of here.
if (scr_pause_check()) {
  exit;
}

//Get the camera moving to where it needs to be.
scr_align_camera(false);
