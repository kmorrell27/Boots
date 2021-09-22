function scr_use_item(argument0) {
  /*********************************************************************
	This script is called when a button item is pressed.  the player needs to
	use the item, if possible, and if  aren't already doing something.

	format:  scr_use_item(item);
	*********************************************************************/

  /*
	If the player isn't in a state to use an item, then get out of here.
	*/

  if (!moveable || slashing || cliff || rolling) {
    exit;
  }

  /*
	Sword Check
	*/
  if (argument0 == Item.SWORD && !charge && !spin) {
    global.player = Character.CAITLIN;
    //Play the appropriate sound effect based on which sword the player has.
    audio_play_sound(sndSlash1, 10, false);
    slashing = true;
    defend = false;
    //Flag as the player as slashing.
    pushing = false;
    //Unflag the player as pushing.
    image_index = 0;
    //Reset their animation.
    s = instance_create_layer(x, y, global.playerLayer, objSword);
    //Create the sword.
    //Now give it the proper sprite based on which sword the player has.
    switch (dir) {
      case Direction.DOWN:
        s.sprite_index = sprSwordDown;
        break;
      case Direction.LEFT:
        s.sprite_index = sprSwordLeft;
        break;
      case Direction.RIGHT:
        s.sprite_index = sprSwordRight;
        break;
      case Direction.UP:
        s.sprite_index = sprSwordUp;
        break;
    }
    // Check for charging in 15 frames
    alarm[0] = global.onesecond / 4;

    // Can't run and swing!
    running = false;
    runTimer = 0;
  }

  /*
	Feather Check
	*/
  if (argument0 == Item.FEATHER && !jumping) {
    // This is tricky but cancel pegasus boots if we are still charging
    if (running && runTimer > 0) {
      running = false;
    }
    audio_play_sound(sndJump, 10, false);
    //Play the Jumping sound.
    //If the player isn't in a sideview area...
    if (!global.sideview) {
      zmax = -16;
      //Prepare the player to go a full tile off of the ground.
    } else {
      //Otherwise, make them go off the ground.
      vspeed = -4.5;
    }
    jumping = true;
    //Flag as the player as jumping.
    pushing = false;
    //Unflag the player as pushing.
    climbing = false;
    //Unflag the player as climbing.
    image_index = 0;
    //Reset their animation.
    scr_player_collide();
    //Check for collision.
  }

  if (argument0 == Item.BOW) {
    global.player = Character.ROSA;
    running = false;
    arrowing = true;
    pushing = false;
    defend = false;
    image_index = 0;
  }

  if (argument0 == Item.BOMB) {
    global.player = Character.BRIAN;
    if (!carrying) {
      heldObject = scr_ahead_check(objLiftable, 8);
      if (heldObject == -1 && !instance_exists(objBomb)) {
        instance_create_depth(x, y, depth + 1, objBomb);
      } else if (heldObject != -1) {
        running = false;
        carrying = true;
        heldObject.lifted = true;
      }
    } else {
      heldObject.lifted = false;
      heldObject.thrown = true;
      heldObject.zmax = -24;
      switch (dir) {
        case Direction.UP:
          heldObject.throwy = -48;
          heldObject.throwspd = -3;
          break;
        case Direction.DOWN:
          heldObject.throwy = 48;
          heldObject.throwspd = 3;
          break;
        case Direction.LEFT:
          heldObject.throwx = -48;
          heldObject.throwspd = -3;
          break;
        case Direction.RIGHT:
          heldObject.throwx = 48;
          heldObject.throwspd = 3;
      }
      heldObject = -1;
      carrying = false;
    }
  }

  if (argument0 == Item.SHIELD) {
    global.player = Character.HAROLD;
    audio_play_sound(sndShield, 10, false);
    defend = true;
    pushing = false;
  }

  if (argument0 == Item.BOOTS) {
    running = true;
    pushing = false;
  }
}
