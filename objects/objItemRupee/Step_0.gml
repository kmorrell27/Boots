event_inherited(); //Call the parent event.

//If the game is paused...
if (scr_pause_chk()) {
  image_speed = 0;
  //Don't animate.
  exit;
  //Get out of this script.
}

/*
The rupee should sit on the non-flashing frame of
animation for some random interval.  Afterwards, it should
animate with a set speed.
*/
if (floor(image_index) == 0) {
  image_speed = 0.0125 + random(0.0125);
} else {
  image_speed = 1;
}

//If Link got the item, but hasn't used it yet, use it now.
if (got && !used) {
  audio_play_sound(sndRupee, 10, false);
  //Play the Rupee Sound Effect.
  scr_get_rupee(amount);
  //Add the amount of Rupees.
  used = true;
  //Flag this as used.
}

/* */
/*  */
