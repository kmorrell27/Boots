//If Link touches this item, and he's able to hold it, get in here.
if (
  place_meeting(x, y, objPlayer) &&
  objPlayer.moveable &&
  objPlayer.z >= -8 &&
  !got
) {
  got = true;
  //Flag this as having been gotten.
  objPlayer.moveable = false;
  //Turn off Link's ability to move.
  objPlayer.hspeed = 0;
  //Reset Link's horizontal speed.
  objPlayer.vspeed = 0;
  //Reset Link's vertical speed.
  objPlayer.hvel = 0;
  //Reset Link's conserved horizontal velocity.
  objPlayer.vvel = 0;
  //Reset Link's conserved vertical velocity.
  objPlayer.rolling = false;
  //Unflag Link as rolling.
  objPlayer.slashing = false;
  //Unflag Link as slashing.
  objPlayer.shooting = false;
  objPlayer.hammering = false;
  x = objPlayer.x + 5 - 5 * (hold == 2);
  //Position this based on the holdtype.
  y = objPlayer.y + objPlayer.z;
  //Position it right on Link's Y.
  depth = objPlayer.depth - 1;
  //Draw this above Link.
  objPlayer.holding = hold;
  //Make Link use the holding sprite necessary.
  //Update Link's sprite.
  with (objPlayer) {
    scr_player_sprite_change();
  }
  drawy = -8;
  //Get a head start in moving up to Link's hands.
  audio_play_sound(getsnd, 10, false);
  //Play the sound this item needs.
}

//If Link picked up this thing, do what in here.
if (got) {
  /*
    If there is still time to hold this item up.
    */
  if (gottmr) {
    gottmr -= 1;
    //Subtract a frame from the time.
    
    //Move up to Link's hand(s).
    if (drawy > -14) {
      drawy -= max(floor((14 + drawy) / 3), 1);
    }
  } else {
    //Otherwise, start moving down to Link and fade out.
    if (drawy < 0) {
      drawy += max(floor((-8 - drawy) / 3), 1);
    }
    image_alpha -= 0.1;
    
    //Once this fades completely out...
    if (image_alpha <= 0) {
      objPlayer.moveable = true;
      //Make Link able to move.
      objPlayer.holding = 0;
      //Unflag Link as holding something.
      instance_destroy();
      //Get rid of this thing.
    }
  }
}

/* */
/*  */
