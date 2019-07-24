/*********************************************************************
GAME PAUSED SECTION
*********************************************************************/
if (scr_pause_chk()) {
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
  image_speed = 0; //Stop animating.
  exit; //Get out of this script.
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

//Flag Link as visible.
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
    scr_link_collide();
  }
}
if (hvel != 0) {
  if (
    (hvel > 0 && place_free(x + 1, y)) ||
    (hvel < 0 && place_free(x - 1, y))
  ) {
    hspeed = hvel;
    hvel = 0;
    scr_link_collide();
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
down = keyboard_check(vk_down) && !keyboard_check(vk_up);
up = keyboard_check(vk_up) && !keyboard_check(vk_down);
left = keyboard_check(vk_left) && !keyboard_check(vk_right);
right = keyboard_check(vk_right) && !keyboard_check(vk_left);

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

//Temporary variable to see if Link is told to roll.
tempcanroll = false;

//If the player presses down...
if (keyboard_check_pressed(vk_down) && !global.sideview) {
  scr_link_doubletap(Direction.DOWN); //Check for down double tapping.
}

//If the player presses up...
if (keyboard_check_pressed(vk_up) && !global.sideview) {
  scr_link_doubletap(Direction.UP); //Check for up double tapping.
}

//If the player presses left...
if (keyboard_check_pressed(vk_left)) {
  scr_link_doubletap(Direction.LEFT); //Check for left double tapping.
}

//If the player presses right...
if (keyboard_check_pressed(vk_right)) {
  scr_link_doubletap(Direction.RIGHT); //Check for right double tapping.
}

/*
If Link was told to roll, we will allow for it, if he's able to.
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
  !spin
) {
  /*
    This block of if statements just assigns Link velocity based on
    which direction he's facing.
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

  scr_link_collide(); //Check for collision.
  doublekeytapdir = noone; //Reset the double key tap check direction.
  doublekeytapdly = 0; //Reset the interval for double key tapping.

  isMoving = false; //Unflag him as moving.
  pushing = false; //And don't flag him as pushing either.
  pushtmr = 0; //And reset the pushing frame counter.
  defend = false; //Unflag Link as defending.
  image_index = 0; //Reset his animation frame.
  rolling = true; //Flag Link as rolling.
  audio_play_sound(sndRoll, 10, false); //Play the rolling sound effect.
  scr_link_sprite_change(); //Update Link's sprite.
}

/*******************************************************************
MOVEMENT SPEED AND FRICTION ALTERATION SECTION
*******************************************************************/

//If Link is STANDING on a slow-walking tile...
if (scr_link_foot_check(objSlowWalk) && !jumping) {
  //Temporary variable to store the calculated slow-walk speed.
  var walkspd = 0.5 - 0.25 * defend;

  maxspd = walkspd; //Assign the slow walking speed.
} else {
  //Temporary variable for the calculated normal movement speed.
  var walkspd = 1 - 0.5 * defend;

  maxspd = walkspd; //Assign standard walking speed.
}

//If Link is rolling...
if (rolling) {
  myfriction = 0.05; //Less friction during rolling.
} else {
  myfriction = 0.25; //Regular friction.
}

/*********************************************************************
JUMPING IN THE AIR SECTION
*********************************************************************/
if (jumping && moveable && !global.sideview) {
  /*
    If the Link hasn't peaked yet, the zspd should be smaller the
    closer he gets to his peak.  Otherwise it should be larger as
    he approaches the ground.
    */
  zspd = max(abs(round((zmax - z) div 3)), 1);

  /*
    If Link hasn't peaked in height yet, subtract the zspd
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
        Link shouldn't come down if he's jumping off a cliff,
        unless he's already made it down the cliff.
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
  zpeak = false; //Reset Link peaking at his jump.
}

/********************************************************************
SIDEVIEW GRAVITY SECTION
********************************************************************/

if (global.sideview) {
  //If Link is in the air...
  if (place_free(x, y + 1)) {
    //If Link is hugging the ceiling...
    if (vvel < 0) {
      vvel += mygravity; //Add the gravity to it.
      //Then make sure Link isn't considered hugging the floor.
      if (vvel > 0) {
        vvel = 0;
      }
    } else {
      gravity = mygravity; //Otherwise, apply gravity.
    }
    //If he wasn't jumping or rolling, reset his frame of animation.
    if (!jumping && !rolling) {
      image_index = 0;
    }
    jumping = true; //Flag him as jumping.
    rolling = false; //Unflag him as rolling.
    scr_link_collide(); //Check for collision.
  } else {
    gravity = 0; //Otherwise, unapply gravity.
    //If he was jumping, play the landing sound.
    if (jumping) {
      audio_play_sound(sndLand, 10, false);
    }
    jumping = false; //Unflag him as jumping.
  }

  //Cap his vertical velocity at a max of 4 pixels per frame.
  if (vspeed > 2) {
    vspeed = 2;
  }
} else {
  gravity = 0; //Otherwise, no gravity.
}

/********************************************************************
MOVEMENT SECTION
*********************************************************************/

//If Link is in a proper state to move...
if (
  moveable &&
  (!slashing || jumping) &&
  !tap &&
  !rolling &&
  !cliff &&
  (!spin || spin > 1)
) {
  /*
    Store the direction Link was just facing in a temporary variable.
    */
  var lastdir = dir;

  //If any directional key held...
  if ((down && !global.sideview) || (up && !global.sideview) || left || right) {
    isMoving = true; //Flag Link as moving.
    //Apply friction to the plane he's not moving in.
    scr_link_friction(false);
    scr_link_collide(); //Check for collision with a wall.
  } else {
    //Otherwise, unflag Link as moving and pushing.
    isMoving = false;
    pushing = false;

    scr_link_friction(true); //Apply friction in all planes.
    scr_link_collide(); //Check for collision with a wall.
  }

  /*
    Change the direction Link is facing based on which directional
    keys are held down.  Link's facing is locked depending on which
    direction he was facing before moving diagonally.  So you won't
    have that problem some engines have where Link will always face
    down when holding down and left for example.  He'll stay facing
    left if he was facing left to begin with, or down.  No, Link
    cannot moonwalk in this engine =P.  No directional change if
    Link is charging, using the spin attack or jumping.
    */
  if (!charge && !spin && !jumping && !defend) {
    if (
      down &&
      ((!left && !right) || (left && dir != Direction.LEFT) || (right && dir != Direction.RIGHT))
    ) {
      dir = Direction.DOWN;
    }
    if (
      up &&
      ((!left && !right) || (left && dir != Direction.LEFT) || (right && dir != Direction.RIGHT))
    ) {
      dir = Direction.UP;
    }
    if (
      left &&
      ((!down && !up) || (down && dir != Direction.DOWN) || (up && dir != Direction.UP))
    ) {
      dir = Direction.LEFT;
    }
    if (
      right &&
      ((!down && !up) || (down && dir != Direction.DOWN) || (up && dir != Direction.UP))
    ) {
      dir = Direction.RIGHT;
    }
  }

  /*
    If Link changed directions, the pushing frame counter needs to
    be reset, since he is no longer pushing in the same direction.
    */
  if (dir != lastdir) {
    pushtmr = 0;
  }

  /*
    Movement for DOWN.
    */
  if (down && !global.sideview) {
    //If there's no wall below link...
    if (place_free(x, y + spd)) {
      /*
            If he's not hugging the wall vertically, then add the
            momentem to his vertical motion.  Otherwise, add it to
            his wall-hugging momentum.
            */
      if (vvel == 0) {
        scr_link_add_vspeed(spd - (spd / 2) * jumping);
      } else {
        scr_link_add_vvel(spd - (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else if (place_free(x - 6, y + spd) && !left && !right && dir == Direction.DOWN) {
      /*
            Otherwise, try to add momentum to the left, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_link_add_hspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_link_add_hvel(-spd + (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else if (place_free(x + 6, y + spd) && !left && !right && dir == Direction.DOWN) {
      /*
            Otherwise, try to add momentum to the right, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_link_add_hspeed(spd - (spd / 2) * jumping);
      } else {
        scr_link_add_hvel(spd - (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else {
      scr_link_collide(); //Check for collision.
      if (dir == Direction.DOWN && !defend && !jumping) {
        /*
                Flag Link as pushing if he isn't charging the sword,
                otherwise, make him perform a sword tap.
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
        If Link can go directly UP without running into a solid,
        then make him move UP, and unflag him as pushing.  Otherwise,
        check to see if he can slide around a corner, and isn't
        already holding that directional key.  If so, do that, unflag
        him as pushing and reset the pushing frame counter. Otherwise,
        get as close to the wall as possible and go no further, and
        flag him as pushing if he is facing in this direction.
        */
    if (place_free(x, y - spd)) {
      /*
            If he's not hugging the wall vertically, then add the
            momentem to his vertical motion.  Otherwise, add it to
            his wall-hugging momentum.
            */
      if (vvel == 0) {
        scr_link_add_vspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_link_add_vvel(-spd + (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else if (place_free(x - 6, y - spd) && !left && !right && dir == Direction.UP) {
      /*
            Otherwise, try to add momentum to the left, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_link_add_hspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_link_add_hvel(-spd + (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else if (place_free(x + 6, y - spd) && !left && !right && dir == Direction.UP) {
      /*
            Otherwise, try to add momentum to the right, to try and
            cut around the corner of a wall.
            */
      if (hvel == 0) {
        scr_link_add_hspeed(spd - (spd / 2) * jumping);
      } else {
        scr_link_add_hvel(spd - (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else {
      scr_link_collide(); //Check for collision.
      if (dir == Direction.UP && !defend && !jumping) {
        /*
                Flag Link as pushing if he isn't charging the sword,
                otherwise, make him perform a sword tap.
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
        If Link can go directly LEFT without running into a solid,
        then make him move LEFT, and unflag him as pushing.  Otherwise,
        check to see if he can slide around a corner, and isn't
        already holding that directional key.  If so, do that, unflag
        him as pushing and reset the pushing frame counter. Otherwise,
        get as close to the wall as possible and go no further, and
        flag him as pushing if he is facing in this direction.
        */
    if (place_free(x - spd, y)) {
      /*
            If he's not hugging the wall horizontally, then add the
            momentem to his horizontal motion.  Otherwise, add it to
            his wall-hugging momentum.
            */
      if (hvel == 0) {
        scr_link_add_hspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_link_add_hvel(-spd + (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
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
        scr_link_add_vspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_link_add_vvel(-spd + (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
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
        scr_link_add_vspeed(spd - (spd / 2) * jumping);
      } else {
        scr_link_add_vvel(spd - (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else {
      scr_link_collide(); //Check for collision.
      if (dir == Direction.LEFT && !defend && !jumping) {
        /*
                Flag Link as pushing if he isn't charging the sword,
                otherwise, make him perform a sword tap.
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
        If Link can go directly RIGHT without running into a solid,
        then make him move RIGHT, and unflag him as pushing.  Otherwise,
        check to see if he can slide around a corner, and isn't
        already holding that directional key.  If so, do that, unflag
        him as pushing and reset the pushing frame counter. Otherwise,
        get as close to the wall as possible and go no further, and
        flag him as pushing if he is facing in this direction.
        */
    if (place_free(x + spd, y)) {
      /*
            If he's not hugging the wall horizontally, then add the
            momentem to his horizontal motion.  Otherwise, add it to
            his wall-hugging momentum.
            */
      if (hvel == 0) {
        scr_link_add_hspeed(spd - (spd / 2) * jumping);
      } else {
        scr_link_add_hvel(spd - (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
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
        scr_link_add_vspeed(-spd + (spd / 2) * jumping);
      } else {
        scr_link_add_vvel(-spd + (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
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
        scr_link_add_vspeed(spd - (spd / 2) * jumping);
      } else {
        scr_link_add_vvel(spd - (spd / 2) * jumping);
      }
      scr_link_collide(); //Check for collision.
      pushing = false; //Unflag Link as pushing.
      pushtmr = 0; //Reset the pushing timer.
    } else {
      scr_link_collide(); //Check for collision.
      if (dir == Direction.RIGHT && !defend && !jumping) {
        /*
                Flag Link as pushing if he isn't charging the sword,
                otherwise, make him perform a sword tap.
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
        If Link has been pushing for about 1/4 of a second...
        */
    if (pushtmr >= global.onesecond / 4) {
      //Temporary variable for a possible cliff ahead of Link.
      var cliffobj = scr_link_ahead_chk(objCliff, 1);

      /*
            If there is a cliff, and Link is in a state to jump 
            down...
            */
      if (cliffobj != -1 && !cliff && !jumping && dir == cliffobj.dir) {
        hspeed = 0; //Reset his horizontal speed.
        vspeed = 0; //Reset his vertical speed.
        pushing = false; //Unflag Link as pushing.
        zmax = -16; //Have Link leave the ground a full tile.
        jumping = true; //Flag Link as jumping.
        //Jump in the direction the cliff wants.
        cliffdir = cliffobj.dir;
        audio_play_sound(sndCliff, 10, false); //Play the cliff jumping sound.
        cliff = true; //Flag Link as jumping off of a cliff.
        image_index = 0; //Reset Link's animation frame.
        scr_link_sprite_change(); //Update Link's sprite.
        /*
                Move Link forward a bit depending on which direction he's
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
        If Link hasn't been pushing for a half second, add this
        frame to the timer.  Otherwise, check for other things.
        */
    if (pushtmr < global.onesecond / 2) {
      pushtmr += 1;
    } else {
      /*
            Define a temporary variable for checking if a pushable
            object is in front of Link.
            */
      var pushobjchk = scr_link_ahead_chk(objPushable, 1);

      /*
            If there was a pushable object in front of Link, then we
            can do things with it.
            */
      if (pushobjchk != -1) {
        /*
                If the object can still be pushed, and Link is trying
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
    //Reset the pushing frame counter if he's not pushing.
    pushtmr = 0;
  }
} else if (rolling) {
  //Otherwise if Link is rolling...

  //If there is a delay on the next smoke object...
  if (smokedly) {
    smokedly -= 1; //Subtract a frame from the delay.
  } else {
    //Otherwise, make a new smoke object here.
    s = instance_create_layer(x, y, "Player", objRollSmoke);
    /*
        If Link is facing down, the smoke should appear behind
        him.  Otherwise, it should be above him.
        */
    if (dir == Direction.DOWN) {
      s.depth = depth + 2;
    } else {
      s.depth = depth - 2;
    }
    smokedly = 8; //Set the delay to 8 frames away.
  }

  doublekeytapdir = noone; //Reset the double key tap check direction.
  doublekeytapdly = 0; //Reset the interval for double key tapping.
  scr_link_friction(true); //Apply friction in all planes.
  scr_link_collide(); //Check for wall collission.
} else {
  /*
    If Link isn't able to move at all or is using an item that locks
    his movement, don't flag him as moving.
    */
  isMoving = false;
  doublekeytapdir = noone; //Reset the double key tap check direction.
  doublekeytapdly = 0; //Reset the interval for double key tapping.
  pushing = false; //And don't flag him as pushing either.
  pushtmr = 0; //And reset the pushing frame counter.
  defend = false; //Unflag him as defending.
  hspeed = 0; //Reset his horizontal speed.
  vspeed = 0; //Reset his vertical speed.
}

/*********************************************************************
ACTION/ITEM KEY PRESS SECTION
*********************************************************************/

/*
This section of code is for the item button checks.  When these buttons
are pressed, Link needs to use the items that are equipped.  That is,
if he is able to at all.
*/

//If the player presses Z...
if (keyboard_check_pressed(ord("Z"))) {
  //Temporary variable for a possible interaction in front of Link.
  var interactchk = scr_link_ahead_chk(objInteractable, 4);

  //If there isn't an interaction in front of Link, use what's on Z.
  if (interactchk == -1 || jumping) {
    scr_use_item(Item.FEATHER);
  } else if (!rolling) {
    /*
        Otherwise, if Link is facing in the right direction,
        flag the object as interacted.
        */
    if (dir == interactchk.interactdir || interactchk.interactdir == noone) {
      interactchk.interacted = true;
    }
  }
}

if (keyboard_check_pressed(ord("A"))) {
	scr_use_item(Item.SWORD);
}

if (keyboard_check_released(ord("A"))) {
	scr_release_button(Item.SWORD);
}

if (keyboard_check_pressed(ord("X"))) {
	scr_use_item(Item.BRACELET);
}

if (keyboard_check_pressed(ord("C"))) {
	scr_use_item(Item.SHIELD);
}

if (keyboard_check_released(ord("C"))) {
	scr_release_button(Item.SHIELD);
}

//If the player presses X, use what's on X.
if (keyboard_check_pressed(ord("S"))) {
  // Todo X button item
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
Call Link's sprite changing script.  This will change his sprite
depending on the current actions he is performing.  It should be
called after the keychecks and movement, so his sprite can change
immediately after the flags for such actions are set.
*/
scr_link_sprite_change();

/*********************************************************************
ANIMATION SPEED SECTION
*********************************************************************/

/*
This section is for Link's animation speed.  He should animate at
various speeds depending on what actions he is performing.  Otherwise
he'll slowly animate for his idle pose, letting him blink, and not
stare into space infinitely.
*/

//If Link is moving or using an item that requires animation...
if (isMoving || slashing || jumping || rolling || tap) {
  if (tap) {
    //2nd frame for tapping.
    image_index = 1;
  } else if (slashing) {
    //Standard Slashing Animation Speed.
    image_speed = 0.25;
  } else if (jumping) {
    //Standard Jumping Animation Speed.
    image_speed = 0.25;
  } else if (rolling) {
    //Standard Rolling Animation Speed.
    image_speed = 0.25;
  } else {
    //Standard Walking Animation Speed.
    image_speed = 0.25;
  }
} else {
  //If Link isn't charging, go in here.
  if (!charge) {
    /*
        Store the current image of animation to see if he's on the
        blinking frames.  If he is, he should animate faster, to finish
        blinking faster.  Otherwise, it should slow to a crawl, at a
        purely random speed, so his intervals of not blinking aren't
        consistent.
        */
    var img = floor(image_index);

    if (img == 0) {
      //Standard First Frame Blinking Animation Speed.
      image_speed = 0.00625 + random(0.003125);
    } else {
      //Standard After-First Frame Blinking Animation Speed.
      image_speed = 0.125;
    }
  } else {
    //Otherwise, freeze his animation entirely.
    image_speed = 0;
    image_index = 0;
  }
}

/*********************************************************************
SLASHING AND SWORD TAPPING SECTION
*********************************************************************/

/*
This is for offsetting Link's sprite when he is attacking.
*/
if (slashing) {
  //Store which image Link's animation is on.
  var img = floor(image_index);

  //If he's facing Down or Up, the sprite offset is all vertical.
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
    This section is for things revolving around Link tapping
    the sword against a wall.
    */

  charge = 1; //Reset the charging.

  //Make his sprite move a pixel.
  if (dir == Direction.DOWN) {
    yoff += 2 - 4 * tapreverse;
  } else if (dir == Direction.UP) {
    yoff -= 2 - 4 * tapreverse;
  } else if (dir == Direction.LEFT) {
    xoff -= 2 - 4 * tapreverse;
  } else if (dir == Direction.RIGHT) {
    xoff += 2 - 4 * tapreverse;
  }

  //If Link's sprite is forward by a quarter tile, do tapping stuff.
  if (!tapreverse && (yoff == 4 || yoff == -4 || xoff == -4 || xoff == 4)) {
    //Temp. variable for bush checking.
    var bushchk = scr_link_ahead_chk(objBush, 8);

    tapreverse = true; //Flag the tapping for the second phase.

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
    } else {
      //Otherwise, play the clanking sound effect.
      audio_play_sound(sndClank, 10, false);
    }
  }

  //If Link's sprite made it back after tapping, go in here.
  if (tapreverse && xoff == 0 && yoff == 0) {
    tap = false; //Unflag the tapping.
    tapreverse = false; //Unflag the finishing of the tapping.
    tapdly = global.onesecond / 5; //Make Link wait for a bit before the next tap.

    //Get rid of the sword if the key is no longer held.
    if (!scr_held_button_chk(Item.SWORD)) {
      charge = 0;
      if (instance_exists(objSword)) {
        with (objSword) {
          instance_destroy();
        }
      }
    }
    scr_link_sprite_change(); //Finally, have Link update his sprite.
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

/* */
/*  */
