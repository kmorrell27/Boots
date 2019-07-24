/*******************************************************************
This script makes Link do whatever when an item button is released.

format:  scr_release_button(item);
*******************************************************************/

/*
Sword Check
*/
if (argument0 == Item.SWORD && charge && !tap) {
  if (charge < global.onesecond) {
    //Get rid of the sword.
    with (objSword) {
      instance_destroy();
    }
  } else {
    audio_play_sound(sndSpin, 10, false);
    //Get rid of the sword.
    with (objSword) {
      instance_destroy();
    }
  }
  charge = 0; //Unflag Link as charging.
  //Update Link's current sprites.
  scr_link_sprite_change();
}

/*
Shield Check
*/
if (argument0 == Item.SHIELD) {
  defend = false; //Unflag Link as defending.
  //Update Link's current sprites.
  scr_link_sprite_change();
}