event_inherited(); //Call the parent event.

//If Link got the item, but hasn't used it yet, use it now.
if (got && !used) {
  audio_play_sound(sndHeart, 10, false); //Play the Heart Sound Effect.
  scr_heal(16); //Heal Link for 16 HP (1 Heart).
  used = true; //Flag this as used.
}
