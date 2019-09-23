event_inherited(); //Call the parent event.

//If the game is paused, get out of this script.
if (scr_pause_chk()) {
  exit;
}

// Stop the detonation if it's lifted
if (lifted) {
	alarm[0] = -1;
	alarm[1] = -1;
	image_index = 0;
	image_speed = 0;
} else if (thrown) {
	alarm[0] = 2 * global.onesecond;
	alarm[1] = 3 * global.onesecond;
}