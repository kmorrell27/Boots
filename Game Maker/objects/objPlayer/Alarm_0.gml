if (slashing) {
  /*
    If the player was slashing...
    */

  //Temp. variable for bush checking.
  var bushchk = scr_ahead_check(objBush, 8);
  /*
    If there is a bush in front of the player, apply an appropriate
    force based on which direction the player is facing, and then get rid
    of the bush.
    */
  if (bushchk != -1) {
    var hspeedgive = 0;
    var vspeedgive = 0;

    if (dir == Direction.DOWN) {
      vspeedgive = 3;
    } else if (dir == Direction.UP) {
      vspeedgive = -3;
    } else if (dir == Direction.LEFT) {
      hspeedgive = -3;
    } else {
      hspeedgive = 3;
    }

    with (bushchk) {
      hspeed = hspeedgive;
      vspeed = vspeedgive;
      instance_destroy();
    }
  }

  slashing = false;
  //Unflag them as slashing.

  /*
    If the player is still holding the sword button, flag the player
    as charging.
    */
  if (scr_sword_button_held()) {
    charge = 1;
  } else {
    //Otherwise delete the sword.
    if (instance_exists(objSword)) {
      with (objSword) {
        instance_destroy();
      }
    }
  }
  image_index = 0;
  //Reset their animation frame.
  scr_player_sprite_change();
  //Finally, have the player update their sprite.
} else if (jumping) {
  //If the player was jumping...
  image_index = 7;
  //Stay on the final frame.
} else if (rolling) {
  //If the player was rolling...
  rolling = false;
  //they're not now.
  image_index = 0;
  //Reset their animation frame.
  scr_player_sprite_change();
  //Finally, have the player update their sprite.
}
