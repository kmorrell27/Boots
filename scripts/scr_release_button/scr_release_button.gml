function scr_release_button(argument0) {
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
  } else if (argument0 == Item.SHIELD) {
    defend = false;
    scr_player_sprite_change();
  }
}
