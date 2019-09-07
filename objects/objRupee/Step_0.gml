event_inherited(); //Call the parent code.

//If the game is paused...
if (scr_pause_chk()) {
  image_speed = 0;
  //Don't animate.
  exit;
  //Get out of this script.
} else {
  image_speed = 1;
  //Standard animation speed.
}

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Get the amount of rupees.
  scr_get_rupee(amt);
  
  //Now flag this item as having been used.
  used = true;
}
