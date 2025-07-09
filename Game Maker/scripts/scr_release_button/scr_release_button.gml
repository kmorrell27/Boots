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
      storedspindir = dir;
      spintimer = global.onesecond / 2;
    }
    charge = 0;
    //Unflag the player as charging.
    //Update the player's current sprites.
    scr_player_sprite_change();
  } else if (argument0 == Item.SHIELD) {
    defend = false;
    scr_player_sprite_change();
  } else if ((argument0 = Item.BOOTS)) {
    running = false;
    runTimer = 0;
    scr_player_sprite_change();
  } else if ((argument0 = Item.BOW)) {
    if (instance_exists(objArrow)) {
      exit;
    }
    var arrow = instance_create_layer(x, y, global.playerLayer, objArrow);
    //Give the arrow the same sprite as the sword.
    switch (dir) {
      case Direction.RIGHT:
        arrow.sprite_index = sprArrowRight;
        break;
      case Direction.LEFT:
        arrow.sprite_index = sprArrowLeft;
        break;
      case Direction.UP:
        arrow.sprite_index = sprArrowUp;
        break;
      case Direction.DOWN:
        arrow.sprite_index = sprArrowDown;
        break;
    }
    arrow.dir = dir;
    arrowing = false;
  }
}
