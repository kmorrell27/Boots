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
  
  /*
    If Link is at full health, has at least the Master Sword,
    and there isn't a sword beam already on the screen...
    */
  if (
    global.hearts == global.heartmax &&
    //global.sword >= 2 &&
    !instance_exists(objSwordBeam)
  ) {
    //Create a Sword Beam right on the sword.
    var beam = instance_create_layer(x + objSword.xoff, y + objSword.yoff, global.playerLayer, objSwordBeam);
    //Give the beam the same sprite as the sword.
    beam.sprite_index = objSword.sprite_index;
    //The beam should travel in the direction Link is facing.
    beam.dir = dir;
    //Play the sword beam sound effect.
    audio_play_sound(sndSwordBeam, 10, false);
  }
  
  slashing = false;
  //Unflag him as slashing.
  
  /*
    If the player is still holding the sword button, flag Link
    as charging.
    */
  if (scr_held_button_chk(Item.SWORD)) {
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
  scr_link_sprite_change();
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
  scr_link_sprite_change();
  //Finally, have Link update his sprite.
}
