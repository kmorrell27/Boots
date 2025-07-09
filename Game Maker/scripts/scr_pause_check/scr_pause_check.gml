function scr_pause_check() {
  return global.pause || instance_exists(objTransition);
}
