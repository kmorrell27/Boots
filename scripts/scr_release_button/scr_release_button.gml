function scr_release_button(argument0) {
  /*******************************************************************
	This script makes the player do whatever when an item button is released.

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
    charge = 0;
    //Unflag the player as charging.
    //Update the player's current sprites.
    scr_player_sprite_change();
  }
}
