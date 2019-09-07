//If the game is paused...
if (scr_pause_chk()) {
  //If there is any vertical motion, conserve it and stop it.
  if (vspeed != 0) {
    lvspeed = vspeed;
    vspeed = 0;
  }
  //If there is any horizontal motion, conserve it and stop it.
  if (hspeed != 0) {
    lhspeed = hspeed;
    hspeed = 0;
  }
  if (image_speed != 0) {
    limgspeed = image_speed;
    image_speed = 0;
  }
  exit;
  //Get out of this script.
}

//If there is any conserved vertical motion, restore and clear it.
if (lvspeed != 0) {
  vspeed = lvspeed;
  lvspeed = 0;
}
//If there is any conserved horizontal motion, restore and clear it.
if (lhspeed != 0) {
  hspeed = lhspeed;
  lhspeed = 0;
}

if (limgspeed != 0) {
  image_speed = limgspeed;
  limgspeed = 0;
}
