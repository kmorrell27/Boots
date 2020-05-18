function scr_use_item(argument0) {
  /*********************************************************************
	This script is called when a button item is pressed.  the player needs to
	use the item, if possible, and if  aren't already doing something.

	format:  scr_use_item(item);
	*********************************************************************/

  /*
	If the player isn't in a state to use an item, then get out of here.
	*/

  if (!moveable || slashing || cliff || rolling || hammering) {
    exit;
  }

  /*
	Sword Check
	*/
  if (argument0 == Item.SWORD && !charge && !spin) {
    if ((party & Character.CAITLIN) == 0) {
      // We need to find our Caitlin
      active = false;
      inactiveSprite = sprite_index;
      image_index = 0;
      for (var i = 0; i < instance_number(objPlayer); i++) {
        var tmp = instance_find(objPlayer, i);
        if ((tmp.party & Character.CAITLIN) > 0) {
          global.playerid = tmp.id;
          break;
        }
      }
    }
    with (global.playerid) {
      active = true;
      global.player = Character.CAITLIN;
      //Play the appropriate sound effect based on which sword the player has.
      audio_play_sound(sndSlash1, 10, false);
      slashing = true;
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
      //Now let's update the player's sprite.
      alarm[0] = global.onesecond / 4;
    }
  }

  /*
	Feather Check
	*/
  if (argument0 == Item.FEATHER && !jumping) {
    if (!active) {
      return;
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
    if ((party & Character.ROSA) == 0) {
      // ROSAAAA
      active = false;
      inactiveSprite = sprite_index;
      image_index = 0;
      for (var i = 0; i < instance_number(objPlayer); i++) {
        var tmp = instance_find(objPlayer, i);
        if ((tmp.party & Character.ROSA) > 0) {
          global.playerid = tmp.id;
          break;
        }
      }
    }
    with (global.playerid) {
      active = true;
      global.player = Character.ROSA;
      pushing = false;
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
      //Now let's update the player's sprite.
      image_index = 0;
    }
  }

  if (argument0 == Item.BOMB) {
    if ((party & Character.BRIAN) == 0) {
      // Brian, The Life Of
      active = false;
      inactiveSprite = sprite_index;
      image_index = 0;
      for (var i = 0; i < instance_number(objPlayer); i++) {
        var tmp = instance_find(objPlayer, i);
        if ((tmp.party & Character.BRIAN) > 0) {
          global.playerid = tmp.id;
          break;
        }
      }
    }
    with (global.playerid) {
      active = true;
      global.player = Character.BRIAN;
      if (!carrying) {
        heldObject = scr_ahead_check(objLiftable, 8);
        if (heldObject == -1 && !instance_exists(objBomb)) {
          instance_create_depth(x, y, depth + 1, objBomb);
        } else if (heldObject != -1) {
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
  }

  if (argument0 == Item.HAMMER) {
    if ((party & Character.HAROLD) == 0) {
      // I have no pun here
      active = false;
      inactiveSprite = sprite_index;
      image_index = 0;
      for (var i = 0; i < instance_number(objPlayer); i++) {
        var tmp = instance_find(objPlayer, i);
        if ((tmp.party & Character.HAROLD) > 0) {
          global.playerid = tmp.id;
          break;
        }
      }
    }
    with (global.playerid) {
      active = true;
      global.player = Character.HAROLD;
      // Hammer time
      audio_play_sound(sndSlash1, 10, false);
      hammering = true;
      //Flag as the player as slashing.
      pushing = false;
      //Unflag the player as pushing.
      image_index = 0;
      //Reset their animation.
      s = instance_create_layer(x, y, global.playerLayer, objHammer);
      //Create the sword.
      //Now give it the proper sprite based on which sword the player has.
      switch (dir) {
        case Direction.DOWN:
          s.sprite_index = sprHammerDown;
          break;
        case Direction.LEFT:
          s.sprite_index = sprHammerLeft;
          break;
        case Direction.RIGHT:
          s.sprite_index = sprHammerRight;
          break;
        case Direction.UP:
          s.sprite_index = sprHammerUp;
          break;
      }
      alarm[0] = global.onesecond / 4;
    }
  }
}
