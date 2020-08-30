/*********************************************************************
GAME PAUSED SECTION
*********************************************************************/
if (!active) {
  sprite_index = inactiveSprite;
}

if (scr_pause_check() || !active) {
  //Conserve vertical speed.
  if (vspeed != 0) {
    lvspeed = vspeed;
    vspeed = 0;
  }
  //Conserve horizontal speed.
  if (hspeed != 0) {
    lhspeed = hspeed;
    hspeed = 0;
  }
  image_speed = 0;
  //Stop animating.
  exit;
  //Get out of this script.
}

//Restore conserved vertical speed.
if (lvspeed != 0) {
  vspeed = lvspeed;
  lvspeed = 0;
}

//Restore conserved horizontal speed.
if (lhspeed != 0) {
  hspeed = lhspeed;
  lhspeed = 0;
}

getDir();
state.step();

var _state = state.get_current();

var jumping = _state == "jumping";
var rolling = _state == "rolling";

/********************************************************************
SIDEVIEW GRAVITY SECTION
********************************************************************/

if (global.sideview) {
  //If the player is in the air...
  if (place_free(x, y + 1)) {
    //If the player is hugging the ceiling...
    if (vvel < 0) {
      vvel += mygravity;
      //Add the gravity to it.
      //Then make sure the player isn't considered hugging the floor.
      if (vvel > 0) {
        vvel = 0;
      }
    } else {
      gravity = mygravity;
      //Otherwise, apply gravity.
    }
    //If  weren't jumping or rolling, reset their frame of animation.
    if (!jumping && !rolling) {
      image_index = 0;
    }
    scr_player_collide();
    //Check for collision.
  } else {
    gravity = 0;
    //Otherwise, unapply gravity.
    //If  were jumping, play the landing sound.
    if (jumping) {
      audio_play_sound(sndLand, 10, false);
    }
    state_switch("idle");
  }

  //Cap their vertical velocity at a max of 4 pixels per frame.
  if (vspeed > 2) {
    vspeed = 2;
  }
} else {
  gravity = 0;
  //Otherwise, no gravity.
}

/*********************************************************************
ACTION/ITEM KEY PRESS SECTION
*********************************************************************/

/*
This section of code is for the item button checks.  When these buttons
are pressed, the player needs to use the items that are equipped.  That is,
if  are able to at all.
*/

//If the player presses Z...
if (scr_bomb_button_pressed()) {
  //Temporary variable for a possible interaction in front of the player.
  var interactchk = scr_ahead_check(objInteractable, 4);

  //If there isn't an interaction in front of the player, use what's on Z.
  if (interactchk == -1 || jumping) {
    scr_use_item(Item.BOMB);
  } else if (!rolling) {
    /*
        Otherwise, if the player is facing in the right direction,
        flag the object as interacted.
        */
    if (dir == interactchk.interactdir || interactchk.interactdir == noone) {
      interactchk.interacted = true;
    }
  }
}

if (scr_sword_button_pressed()) {
  scr_use_item(Item.SWORD);
}

if (scr_sword_button_released()) {
  scr_release_button(Item.SWORD);
}

if (scr_shield_button_pressed()) {
  scr_use_item(Item.SHIELD);
}

if (scr_jump_button_pressed()) {
  scr_use_item(Item.FEATHER);
}

if (scr_split_button_pressed()) {
  scr_split_up();
}

//If the player presses X, use what's on X.
if (scr_arrow_button_pressed()) {
  scr_use_item(Item.BOW);
}

if (scr_arrow_button_released()) {
  scr_release_button(Item.BOW);
}

/********************************************************************
SWORD CHARGING SECTION
********************************************************************/
if (charge) {
  //If there is still a delay on the next tap, subtract a frame.
  if (tapdly) {
    tapdly -= 1;
  }

  //If the charge isn't fully done, add a frame to the counter.
  if (charge < global.onesecond && !tap) {
    charge += 1;
    /*
        If the charging has just reached maximum, play the charge
        sound.
        */
    if (charge >= global.onesecond) {
      audio_play_sound(sndCharge, 10, false);
    }
  }
} else {
  tapdly = 0;
}

/*
Call the player's sprite changing script.  This will change their sprite
depending on the current actions  are performing.  It should be
called after the keychecks and movement, so their sprite can change
immediately after the flags for such actions are set.
*/
scr_player_sprite_change();

/*********************************************************************
ANIMATION SPEED SECTION
*********************************************************************/

/*
This section is for the player's animation speed.   should animate at
various speeds depending on what actions  are performing.
*/

//If the player is moving or using an item that requires animation...
if (isMoving() || slashing || jumping || rolling || tap) {
  if (tap) {
    //2nd frame for tapping.
    image_index = 1;
  } else if (slashing) {
    //Stop moving
    image_speed = 0;
  } else if (_state == "jumping") {
    //Standard Jumping Animation Speed.
    image_speed = 0;
  } else if (_state == "rolling") {
    //Standard Rolling Animation Speed.
    image_speed = 1;
  } else {
    //Standard Walking Animation Speed.
    image_speed = 1;
  }
} else {
  //Otherwise, freeze their animation entirely.
  image_speed = 0;
  image_index = 0;
}

/*********************************************************************
SLASHING AND SWORD TAPPING SECTION
*********************************************************************/

/*
This is for offsetting the player's sprite when  are attacking.
*/
if (slashing) {
  //Store which image the player's animation is on.
  var img = floor(image_index);

  //If they're facing Down or Up, the sprite offset is all vertical.
  if (dir == Direction.DOWN || dir == Direction.UP) {
    xoff = 0;
    yoff = img * 2 - 4 * (img == 3);
    if (dir == Direction.UP) {
      yoff *= -1;
    }
  } else {
    //Otherwise, the offset is all horizontal.
    xoff = img * 2 - 4 * (img == 3);
    yoff = 0;
    if (dir == Direction.LEFT) {
      xoff *= -1;
    }
  }
} else if (tap) {
  /*
    This section is for things revolving around the player tapping
    the sword against a wall.
    */

  charge = 1;
  //Reset the charging.

  //Make their sprite move a pixel.
  if (dir == Direction.DOWN) {
    yoff += 2 - 4 * tapreverse;
  } else if (dir == Direction.UP) {
    yoff -= 2 - 4 * tapreverse;
  } else if (dir == Direction.LEFT) {
    xoff -= 2 - 4 * tapreverse;
  } else if (dir == Direction.RIGHT) {
    xoff += 2 - 4 * tapreverse;
  }

  //If the player's sprite is forward by a quarter tile, do tapping stuff.
  if (!tapreverse && (yoff == 4 || yoff == -4 || xoff == -4 || xoff == 4)) {
    //Temp. variable for bush checking.
    var bushchk = scr_ahead_check(objBush, 8);

    tapreverse = true;
    //Flag the tapping for the second phase.

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
    } else {
      //Otherwise, play the clanking sound effect.
      audio_play_sound(sndClank, 10, false);
    }
  }

  //If the player's sprite made it back after tapping, go in here.
  if (tapreverse && xoff == 0 && yoff == 0) {
    tap = false;
    //Unflag the tapping.
    tapreverse = false;
    //Unflag the finishing of the tapping.
    tapdly = global.onesecond / 5;
    //Make the player wait for a bit before the next tap.

    //Get rid of the sword if the key is no longer held.
    if (!scr_sword_button_held()) {
      charge = 0;
      if (instance_exists(objSword)) {
        with (objSword) {
          instance_destroy();
        }
      }
    }
    scr_player_sprite_change();
    //Finally, have the player update their sprite.
  }
} else {
  //Reset the sprite offset.
  xoff = 0;
  yoff = 0;
}

// Are we falling in a pit?
if (!jumping && scr_player_foot_check(objPit)) {
  ground_dx = 0;
  ground_dy = 0;
  if (point_distance(x, y, last_solid_x, last_solid_y) > 16) {
    x = last_solid_x;
    y = last_solid_y;
  }
  if (x > last_solid_x) {
    ground_dx = 1;
  } else if (x < last_solid_x) {
    ground_dx = -1;
  }

  if (y > last_solid_y) {
    ground_dy = 1;
  } else if (y < last_solid_y) {
    ground_dy = -1;
  }
  maxspd = 1 / 3;
} else if (!place_meeting(x, y, objPit)) {
  last_solid_x = x;
  last_solid_y = y;
  ground_dx = 0;
  ground_dy = 0;
  maxspd = 1;
}

// Apply additional movement if necessary
if (get_timer() >= pit_timer && (ground_dx != 0 || ground_dy != 0)) {
  pit_timer = get_timer() + 60000;
  var _moved = false;
  if (place_free(x + ground_dx, y + ground_dy)) {
    x += ground_dx;
    y += ground_dy;
    _moved = true;
  } else if (place_free(x, y + ground_dy)) {
    y += ground_dy;
    _moved = true;
  } else if (place_free(x + ground_dx, y)) {
    x += ground_dx;
    _moved = true;
  }

  if (!_moved) {
    // We can't get closer for some reason. Just fall
    maxspd = 1;
    x = last_solid_x;
    y = last_solid_y;
  }
}

if (place_meeting(x, y, objLaser) && !rolling) {
  x = global.lastplayerx;
  y = global.lastplayery;
  speed = 0;
}

depth = -y;
