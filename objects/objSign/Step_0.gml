//If the game is paused, leave this script.
if (scr_pause_chk()) {
  exit;
}

//If Link has interacted with the chest...
if (interacted) {
  var ypos = 0;
  if (objLink.y < 48) {
    // We're gonna be covered by the text box
    ypos = 96;
  }
  var txt = instance_create_layer(0, ypos, global.playerLayer, objTextBox);
  txt.str = message;
  objTextBox.pos = ypos > 0 ? Direction.DOWN : Direction.UP;
  interacted = false;
}
