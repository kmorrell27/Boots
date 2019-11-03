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

//Flag the player as visible.
visible = true;

//Keyboard Key variables.
down = false;
up = false;
left = false;
right = false;

//Restore any conserved movement force, if possible.
if (vvel != 0) {
  if (
    (vvel > 0 && place_free(x, y + 1)) ||
    (vvel < 0 && place_free(x, y - 1))
  ) {
    vspeed = vvel;
    vvel = 0;
    scr_player_collide();
  }
}
if (hvel != 0) {
  if (
    (hvel > 0 && place_free(x + 1, y)) ||
    (hvel < 0 && place_free(x - 1, y))
  ) {
    hspeed = hvel;
    hvel = 0;
    scr_player_collide();
  }
}
/*******************************************************************
ARROW KEY CHECKING SECTION
*******************************************************************/

/*
This block of code checks for the corresponding directional keys,
while considering the opposite.  If both up and down are held
together, for example, then they cancel out.
*/
if (gamepad_is_connected(0)) {
  gamepad_set_axis_deadzone(0, 0.5);
  up = gamepad_axis_value(0, gp_axislv) < 0 || gamepad_button_check(0, gp_padu);
  down =
    gamepad_axis_value(0, gp_axislv) > 0 || gamepad_button_check(0, gp_padd);
  left =
    gamepad_axis_value(0, gp_axislh) < 0 || gamepad_button_check(0, gp_padl);
  right =
    gamepad_axis_value(0, gp_axislh) > 0 || gamepad_button_check(0, gp_padr);

  if (up && down) {
    up = false;
    down = false;
  }
  if (left && right) {
    left = false;
    right = false;
  }
} else {
  down = keyboard_check(vk_down) && !keyboard_check(vk_up);
  up = keyboard_check(vk_up) && !keyboard_check(vk_down);
  left = keyboard_check(vk_left) && !keyboard_check(vk_right);
  right = keyboard_check(vk_right) && !keyboard_check(vk_left);
}

/*
This section checks for double tapping a directional key.
*/

/*
If there was an interval for double tapping an arrow key, subtract
a frame now.  If it becomes 0 (or smaller, somehow) reset the double
tap checking direction, because it's no longer valid.
*/
if (doublekeytapdly) {
  doublekeytapdly -= 1;
  if (doublekeytapdly <= 0) {
    doublekeytapdir = noone;
  }
}

//Temporary variable to see if the player is told to roll.
tempcanroll = false;

//If the player presses down...
if (scr_down_button_pressed() && !global.sideview) {
  scr_doubletap(Direction.DOWN);
  //Check for down double tapping.
}

//If the player presses up...
if (scr_up_button_pressed() && !global.sideview) {
  scr_doubletap(Direction.UP);
  //Check for up double tapping.
}

//If the player presses left...
if (scr_left_button_pressed()) {
  scr_doubletap(Direction.LEFT);
  //Check for left double tapping.
}

//If the player presses right...
if (scr_right_button_pressed()) {
  scr_doubletap(Direction.RIGHT);
  //Check for right double tapping.
}

/*
If the player was told to roll, we will allow for it, if they're able to.
*/
if (
  tempcanroll &&
  moveable &&
  !rolling &&
  !charge &&
  !slashing &&
  !jumping &&
  !tap &&
  !cliff &&
  !spin &&
  !hammering
) {
  /*
    This block of if statements just assigns the player velocity based on
    which direction they're facing.
    */
  if (dir == Direction.DOWN) {
    vspeed = maxspd * 2.5;
  } else if (dir == Direction.UP) {
    vspeed = -maxspd * 2.5;
  } else if (dir == Direction.LEFT) {
    hspeed = -maxspd * 2.5;
  } else if (dir == Direction.RIGHT) {
    hspeed = maxspd * 2.5;
  }

  scr_player_collide();
  //Check for collision.
  doublekeytapdir = noone;
  //Reset the double key tap check direction.
  doublekeytapdly = 0;
  //Reset the interval for double key tapping.

  isMoving = false;
  //Unflag them as moving.
  pushing = false;
  //And don't flag them as pushing either.
  pushtmr = 0;
  //And reset the pushing frame counter.
  image_index = 0;
  //Reset their animation frame.
  rolling = true;
  alarm[0] = global.onesecond / 3;
  //Flag the player as rolling.
  audio_play_sound(sndRoll, 10, false);
  //Play the rolling sound effect.
  scr_player_sprite_change();
  //Update the player's sprite.
}

/*******************************************************************
MOVEMENT SPEED AND FRICTION ALTERATION SECTION
*******************************************************************/

//If the player is STANDING on a slow-walking tile...
if (scr_player_foot_check(objSlowWalk) && !jumping) {
  maxspd = 0.5;
  //Assign the slow walking speed.
} else {
  maxspd = 1;
  //Assign standard walking speed.
}

//If the player is rolling...
if (rolling) {
  myfriction = 0.05;
  //Less friction during rolling.
} else {
  myfriction = 0.25;
  //Regular friction.
}

/*********************************************************************
JUMPING IN THE AIR SECTION
*********************************************************************/
if (jumping && moveable && !global.sideview) {
  /*
    If the the player hasn't peaked yet, the zspd should be smaller the
    closer  get to their peak.  Otherwise it should be larger as
     approach the ground.
    */
  zspd = max(abs(round(floor((zmax - z) / 3))), 1);

  /*
    If the player hasn't peaked in height yet, subtract the zspd
    from the z value.  Otherwise, add it.
    */
  if (!zpeak) {
    if (z - zspd >= zmax) {
      z -= zspd;
    } else {
      z = zmax;
      zpeak = true;
    }
  } else {
    /*
        the player shouldn't come down if they're jumping off a cliff,
        unless they're already made it down the cliff.
        */
    if (!cliff || (cliff && place_free(x, y))) {
      if (z + zspd <= 0) {
        z += zspd;
      } else {
        z = 0;
        zpeak = false;
        zmax = 0;
        cliff = false;
        jumping = false;
        audio_play_sound(sndLand, 10, false);
      }
    }
  }
} else {
  zpeak = false;
  //Reset the player peaking at their jump.
}

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
    jumping = true;
    //Flag them as jumping.
    rolling = false;
    //Unflag them as rolling.
    scr_player_collide();
    //Check for collision.
  } else {
    gravity = 0;
    //Otherwise, unapply gravity.
    //If  were jumping, play the landing sound.
    if (jumping) {
      audio_play_sound(sndLand, 10, false);
    }
    jumping = false;
    //Unflag them as jumping.
  }

  //Cap their vertical velocity at a max of 4 pixels per frame.
  if (vspeed > 2) {
    vspeed = 2;
  }
} else {
  gravity = 0;
  //Otherwise, no gravity.
}

/********************************************************************
MOVEMENT SECTION
*********************************************************************/

//If the player is in a proper state to move...
if (
  moveable &&
  ((!slashing && !hammering) || jumping) &&
  !tap &&
  !rolling &&
  !cliff &&
  (!spin || spin > 1)
) {
  /*
    Store the direction the player was just facing in a temporary variable.
    */
  var lastdir = dir;

  //If any directional key held...
  if ((down && !global.sideview) || (up && !global.sideview) || left || right) {
    isMoving = true;
    //Flag the player as moving.
    //Apply friction to the plane they're not moving in.
    scr_player_friction(false);
    scr_player_collide();
    //Check for collision with a wall.
  } else {
    //Otherwise, unflag the player as moving and pushing.
    isMoving = false;
    pushing = false;

    scr_player_friction(true);
    //Apply friction in all planes.
    scr_player_collide();
    //Check for collision with a wall.
  }

  /*
    Change the direction the player is facing based on which directional
    keys are held down.  the player's facing is locked depending on which
    direction  were facing before moving diagonally.  So you won't
    have that problem some engines have where the player will always face
    down when holding down and left for example.  'll stay facing
    left if  were facing left to begin with, or down.  No, the player
    cannot moonwalk in this engine =P.  No directional change if
    the player is charging, using the spin attack or jumping.
    */
  if (!charge && !spin && !jumping) {
    if (
      down &&
      ((!left && !right) ||
        (left && dir != Direction.LEFT) ||
        (right && dir != Direction.RIGHT))
    ) {
      dir = Direction.DOWN;
    }
    if (
      up &&
      ((!left && !right) ||
        (left && dir != Direction.LEFT) ||
        (right && dir != Direction.RIGHT))
    ) {
      dir = Direction.UP;
    }
    if (
      left &&
      ((!down && !up) ||
        (down && dir != Direction.DOWN) ||
        (up && dir != Direction.UP))
    ) {
      dir = Direction.LEFT;
    }
    if (
      right &&
      ((!down && !up) ||
        (down && dir != Direction.DOWN) ||
        (up && dir != Direction.UP))
    ) {
      dir = Direction.RIGHT;
    }
  }

  /*
    If the player changed directions, the pushing frame counter needs to
    be reset, since  are no longer pushing in the same direction.
    */
  if (dir != lastdir) {
    pushtmr = 0;
  }

  /*
    Movement for DOWN.
    */
  if (down && !global.sideview) {
    //If there's no wall below the player...
    if (place_free(x, y + spd)) {
      /*
            If they're not hugging the wall vertically, then add the
            momentem to their vertical motion.  Otherwise, add it to
            their wall-hugging momentum.
            */
      if (vvel == 0) {
        scr_add_vspeed(spd - (spd / 2) * jumping);
      } else {
        scr_add_vvel(spd - (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x - 6, y + spd) &&
      !left &&
      !right &&
      dir == Direction.DOWN
    ) {
      /*
            Otherwise, try to add momentum to the left, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_add_hspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_add_hvel(-spd + (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x + 6, y + spd) &&
      !left &&
      !right &&
      dir == Direction.DOWN
    ) {
      /*
            Otherwise, try to add momentum to the right, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_add_hspeed(spd - (spd / 2) * jumping);
      } else {
        scr_add_hvel(spd - (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else {
      scr_player_collide();
      //Check for collision.
      if (dir == Direction.DOWN && !jumping) {
        /*
                Flag the player as pushing if  aren't charging the sword,
                otherwise, make them perform a sword tap.
                */
        if (!charge) {
          pushing = true;
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  /*
    Movement for UP.
    */
  if (up && !global.sideview) {
    /*
        If the player can go directly UP without running into a solid,
        then make them move UP, and unflag them as pushing.  Otherwise,
        check to see if  can slide around a corner, and isn't
        already holding that directional key.  If so, do that, unflag
        them as pushing and reset the pushing frame counter. Otherwise,
        get as close to the wall as possible and go no further, and
        flag them as pushing if  are facing in this direction.
        */
    if (place_free(x, y - spd)) {
      /*
            If they're not hugging the wall vertically, then add the
            momentem to their vertical motion.  Otherwise, add it to
            their wall-hugging momentum.
            */
      if (vvel == 0) {
        scr_add_vspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_add_vvel(-spd + (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x - 6, y - spd) &&
      !left &&
      !right &&
      dir == Direction.UP
    ) {
      /*
            Otherwise, try to add momentum to the left, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_add_hspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_add_hvel(-spd + (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x + 6, y - spd) &&
      !left &&
      !right &&
      dir == Direction.UP
    ) {
      /*
            Otherwise, try to add momentum to the right, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_add_hspeed(spd - (spd / 2) * jumping);
      } else {
        scr_add_hvel(spd - (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else {
      scr_player_collide();
      //Check for collision.
      if (dir == Direction.UP && !jumping) {
        /*
                Flag the player as pushing if  aren't charging the sword,
                otherwise, make them perform a sword tap.
                */
        if (!charge) {
          pushing = true;
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  /*
    Movement for LEFT.
    */
  if (left) {
    /*
        If the player can go directly LEFT without running into a solid,
        then make them move LEFT, and unflag them as pushing.  Otherwise,
        check to see if  can slide around a corner, and isn't
        already holding that directional key.  If so, do that, unflag
        them as pushing and reset the pushing frame counter. Otherwise,
        get as close to the wall as possible and go no further, and
        flag them as pushing if  are facing in this direction.
        */
    if (place_free(x - spd, y)) {
      /*
            If they're not hugging the wall horizontally, then add the
            momentem to their horizontal motion.  Otherwise, add it to
            their wall-hugging momentum.
            */
      if (hvel == 0) {
        scr_add_hspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_add_hvel(-spd + (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x - spd, y - 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.LEFT
    ) {
      /*
            Otherwise, try to add momentum to the north, to try and
            cut around the corner of a wall.
            */
      if (vvel == 0) {
        scr_add_vspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_add_vvel(-spd + (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x - spd, y + 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.LEFT
    ) {
      /*
            Otherwise, try to add momentum to the south, to try and
            cut around the corner of a wall.
            */
      if (vvel == 0) {
        scr_add_vspeed(spd - (spd / 2) * jumping);
      } else {
        scr_add_vvel(spd - (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else {
      scr_player_collide();
      //Check for collision.
      if (dir == Direction.LEFT && !jumping) {
        /*
                Flag the player as pushing if  aren't charging the sword,
                otherwise, make them perform a sword tap.
                */
        if (!charge) {
          pushing = true;
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  /*
    Movement for RIGHT.
    */
  if (right) {
    /*
        If the player can go directly RIGHT without running into a solid,
        then make them move RIGHT, and unflag them as pushing.  Otherwise,
        check to see if  can slide around a corner, and isn't
        already holding that directional key.  If so, do that, unflag
        them as pushing and reset the pushing frame counter. Otherwise,
        get as close to the wall as possible and go no further, and
        flag them as pushing if  are facing in this direction.
        */
    if (place_free(x + spd, y)) {
      /*
            If they're not hugging the wall horizontally, then add the
            momentem to their horizontal motion.  Otherwise, add it to
            their wall-hugging momentum.
            */
      if (hvel == 0) {
        scr_add_hspeed(spd - (spd / 2) * jumping);
      } else {
        scr_add_hvel(spd - (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x + spd, y - 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.RIGHT
    ) {
      /*
            Otherwise, try to add momentum to the north, to try and
            cut around the corner of a wall.
            */
      if (vvel == 0) {
        scr_add_vspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_add_vvel(-spd + (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else if (
      place_free(x + spd, y + 6) &&
      !global.sideview &&
      !down &&
      !up &&
      dir == Direction.RIGHT
    ) {
      /*
            Otherwise, try to add momentum to the south, to try and
            cut around the corner of a wall.
            */
      if (vvel == 0) {
        scr_add_vspeed(spd - (spd / 2) * jumping);
      } else {
        scr_add_vvel(spd - (spd / 2) * jumping);
      }
      scr_player_collide();
      //Check for collision.
      pushing = false;
      //Unflag the player as pushing.
      pushtmr = 0;
      //Reset the pushing timer.
    } else {
      scr_player_collide();
      //Check for collision.
      if (dir == Direction.RIGHT && !jumping) {
        /*
                Flag the player as pushing if  aren't charging the sword,
                otherwise, make them perform a sword tap.
                */
        if (!charge) {
          pushing = true;
        } else if (!tapdly) {
          tap = true;
        }
      }
    }
  }

  /*
    Pushing Segment
    */
  if (pushing) {
    /*
        If the player has been pushing for about 1/4 of a second...
        */
    if (pushtmr >= global.onesecond / 4) {
      //Temporary variable for a possible cliff ahead of the player.
      var cliffobj = scr_ahead_check(objCliff, 1);

      /*
            If there is a cliff, and the player is in a state to jump 
            down...
            */
      if (cliffobj != -1 && !cliff && !jumping && dir == cliffobj.dir) {
        hspeed = 0;
        //Reset their horizontal speed.
        vspeed = 0;
        //Reset their vertical speed.
        pushing = false;
        //Unflag the player as pushing.
        zmax = -16;
        //Have the player leave the ground a full tile.
        jumping = true;
        //Flag the player as jumping.
        //Jump in the direction the cliff wants.
        cliffdir = cliffobj.dir;
        audio_play_sound(sndCliff, 10, false);
        //Play the cliff jumping sound.
        cliff = true;
        //Flag the player as jumping off of a cliff.
        image_index = 0;
        //Reset the player's animation frame.
        scr_player_sprite_change();
        //Update the player's sprite.
        /*
                Move the player forward a bit depending on which direction they're
                jumping down.
                */
        if (cliffdir == Direction.DOWN) {
          y += 2;
        } else if (cliffdir == Direction.UP) {
          y -= 2;
        } else if (cliffdir == Direction.LEFT) {
          x -= 2;
        } else {
          x += 2;
        }
      }
    }

    /*
        If the player hasn't been pushing for a half second, add this
        frame to the timer.  Otherwise, check for other things.
        */
    if (pushtmr < global.onesecond / 2) {
      pushtmr += 1;
    } else {
      /*
            Define a temporary variable for checking if a pushable
            object is in front of the player.
            */
      var pushobjchk = scr_ahead_check(objPushable, 1);

      /*
            If there was a pushable object in front of the player, then we
            can do things with it.
            */
      if (pushobjchk != -1) {
        /*
                If the object can still be pushed, and the player is trying
                to push the object in the right direction, if
                applicable...
                */
        if (
          pushobjchk.pushes != 0 &&
          pushobjchk.pushx == 0 &&
          pushobjchk.pushy == 0 &&
          (pushobjchk.pushdir == noone || pushobjchk.pushdir == dir)
        ) {
          /*
                    Then set it's pushing distance to one tile ahead,
                    if the object can move forward and isn't at the edge
                    of the room, and play the pushing sound effect.
                    */
          if (dir == Direction.DOWN) {
            if (
              place_free(pushobjchk.x, pushobjchk.y + 16) &&
              pushobjchk.y + 16 < room_height
            ) {
              pushobjchk.pushy = 16;
              audio_play_sound(sndPush, 10, false);
            }
          } else if (dir == Direction.UP) {
            if (
              place_free(pushobjchk.x, pushobjchk.y - 16) &&
              pushobjchk.y - 16 >= 0
            ) {
              pushobjchk.pushy = -16;
              audio_play_sound(sndPush, 10, false);
            }
          } else if (dir == Direction.LEFT) {
            if (
              place_free(pushobjchk.x - 16, pushobjchk.y) &&
              pushobjchk.x - 16 >= 0
            ) {
              pushobjchk.pushx = -16;
              audio_play_sound(sndPush, 10, false);
            }
          } else {
            if (
              place_free(pushobjchk.x + 16, pushobjchk.y) &&
              pushobjchk.x + 16 < room_width
            ) {
              pushobjchk.pushx = 16;
              audio_play_sound(sndPush, 10, false);
            }
          }
        }
      }
    }
  } else {
    //Reset the pushing frame counter if they're not pushing.
    pushtmr = 0;
  }
} else if (rolling) {
  //Otherwise if the player is rolling...

  //If there is a delay on the next smoke object...
  if (smokedly) {
    smokedly -= 1;
    //Subtract a frame from the delay.
  } else {
    //Otherwise, make a new smoke object here.
    s = instance_create_layer(x, y, "Player", objRollSmoke);
    /*
        If the player is facing down, the smoke should appear behind
        them.  Otherwise, it should be above them.
        */
    if (dir == Direction.DOWN) {
      s.depth = depth + 2;
    } else {
      s.depth = depth - 2;
    }
    smokedly = 8;
    //Set the delay to 8 frames away.
  }

  doublekeytapdir = noone;
  //Reset the double key tap check direction.
  doublekeytapdly = 0;
  //Reset the interval for double key tapping.
  scr_player_friction(true);
  //Apply friction in all planes.
  scr_player_collide();
  //Check for wall collission.
} else {
  /*
    If the player isn't able to move at all or is using an item that locks
    their movement, don't flag them as moving.
    */
  isMoving = false;
  doublekeytapdir = noone;
  //Reset the double key tap check direction.
  doublekeytapdly = 0;
  //Reset the interval for double key tapping.
  pushing = false;
  //And don't flag them as pushing either.
  pushtmr = 0;
  //And reset the pushing frame counter.
  hspeed = 0;
  //Reset their horizontal speed.
  vspeed = 0;
  //Reset their vertical speed.
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

if (scr_hammer_button_pressed()) {
  scr_use_item(Item.HAMMER);
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
if (isMoving || slashing || jumping || rolling || tap || hammering) {
  if (tap) {
    //2nd frame for tapping.
    image_index = 1;
  } else if (slashing || hammering) {
    //Stop moving
    image_speed = 0;
  } else if (jumping) {
    //Standard Jumping Animation Speed.
    image_speed = 1;
  } else if (rolling) {
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

/*
if (place_meeting(x,y,objEnemy))
{
    var; e=-1;
    e=instance_place(x,y,objEnemy);

    direction=point_direction(e.x,e.y,x,y);
    speed=4;    
}
*/
