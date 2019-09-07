event_inherited(); //Call the Parent Event.

//If the game is paused...
if (scr_pause_chk()) {
  gravity = 0;
  //No gravity.
  image_speed = 0;
  //Don't animate.
  exit;
  //Get out of this script.
}

gravity = 0.5; //How fast this "falls."
image_speed = 0.25; //Animation speed.
image_alpha -= 0.05; //Slowly start fading away.
//If this object has faded completely, destroy it.
if (image_alpha <= 0) {
  instance_destroy();
}
