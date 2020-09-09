function scr_pause_check() {
  /*
	This script will return true if any conditions are met that consider
	the game as being paused.
	*/

  return global.pause || instance_exists(objTransition);
}
