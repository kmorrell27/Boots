event_inherited(); //Call the parent event.

//If Link got the item, but hasn't used it yet, use it now.
if (got && !used) {
  audio_play_sound(sndFairy, 10, false);
  //Play the Fairy Sound Effect.
  scr_heal(80);
  //Heal Link for 80 HP (5 Hearts).
  used = true;
  //Flag this as used.
}
