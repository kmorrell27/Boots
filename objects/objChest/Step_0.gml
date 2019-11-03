//If the game is paused, leave this script.
if (scr_pause_check()) {
  exit;
}

//If the player has interacted with the chest...
if (interacted && !opened) {
  audio_play_sound(sndChest, 10, false);
  //Play the chest sound.
  opened = true;
  //Flg the chest as opened.
  objPlayer.moveable = false;
  //Disable the player's movement.
}

//If the chest has been opened, do what's in here.
if (opened) {
  image_index = 1;
  //Use the opened stage of the sprite.

  //If there is still showtime left...
  if (opentmr) {
    /*
        If the item sprite hasn't moved all the way up yet,
        move it up more.  Algebra to make it slow down the
        closer it gets.
        */
    if (drawy > -8) {
      drawy -= max(floor((-8 - drawy) / 2), 1);
    }

    /*
        If there are more than 20 frames left on the show time, then
        make the item fade in.  Otherwise, make it fade out.
        */
    if (opentmr > 20) {
      if (itemalpha < 1) {
        itemalpha += 0.1;
      }
    } else {
      itemalpha -= 0.1;
    }

    opentmr -= 1;
    //Subtract a frame from the showtime.

    //If the showtime is all gone...
    if (opentmr == 0) {
      //If this chest is to be stored, do so.
      if (chestnum > -1) {
        global.chest[chestnum] = true;
      }
      objPlayer.moveable = true;
      //Reflag the player as able to move.
      //And then give them the item the chest has.
      instance_create_layer(
        objPlayer.x + 4,
        objPlayer.y + 4,
        global.playerLayer,
        itemobj
      );
    }
  }
}

/* */
/*  */
