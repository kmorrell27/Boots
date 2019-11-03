//If the game is paused, leave this script.
if (scr_pause_check()) {
  exit;
}

//If Link has interacted with the chest...
if (interacted) {
  var ypos = 0;
  if (objPlayer.y < 48) {
    // We're gonna be covered by the text box
    ypos = 96;
  }
  var txt = instance_create_depth(0, ypos, -15998, objTextBox);
  txt.str = message;
  objTextBox.pos = ypos > 0 ? Direction.DOWN : Direction.UP;
  interacted = false;
}
