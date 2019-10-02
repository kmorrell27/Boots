if (slashing) {
  /*
    If Link was slashing...
    */
  
  //Temp. variable for bush checking.
  var bushchk = scr_link_ahead_chk(objBush, 8);
  /*
    If there is a bush in front of Link, apply an appropriate
    force based on which direction Link is facing, and then get rid
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
  //Unflag him as slashing.
  
  /*
    If the player is still holding the sword button, flag Link
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
  //Reset his animation frame.
  scr_player_sprite_change();
  //Finally, have Link update his sprite.
} else if (jumping) {
  //If Link was jumping...
  image_index = 7;
  //Stay on the final frame.
} else if (rolling) {
  //If Link was rolling...
  rolling = false;
  //He's not now.
  image_index = 0;
  //Reset his animation frame.
  scr_player_sprite_change();
  //Finally, have Link update his sprite.
} else if (hammering) {
  if (instance_exists(objHammer)) {
    instance_destroy(objHammer);
  }
  hammering = false;
  image_index = 0;
  scr_player_sprite_change();
}
