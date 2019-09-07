/*********************************************************************
This script is called when a button item is pressed.  Link needs to
use the item, if possible, and if he isn't already doing something.

format:  scr_use_item(item);
*********************************************************************/

/*
If Link isn't in a state to use an item, then get out of here.
*/
if (!moveable || slashing || cliff || rolling) {
  exit;
}

/*
If there isn't an item equipped on this button, play the error
sound.
*/
if (argument0 == noone) {
  audio_stop_sound(sndError);
  audio_play_sound(sndError, 10, false);
}

/*
Sword Check
*/
if (argument0 == Item.SWORD && !charge && !spin) {
  //Play the appropriate sound effect based on which sword Link has.
  audio_play_sound(
    asset_get_index("sndSlash" + string(global.sword)),
    10,
    false
  );
  slashing = true; //Flag as Link as slashing.
  pushing = false; //Unflag Link as pushing.
  image_index = 0; //Reset his animation.
  s = instance_create_layer(x, y, global.playerLayer, objSword); //Create the sword.
  //Now give it the proper sprite based on which sword Link has.
  s.sprite_index = asset_get_index(
    "sprSword" + string(global.tunic + 1) + "S" + scr_get_direction(dir)
  );
  //Now let's update Link's sprite.
  scr_link_sprite_change();
}

/*
Feather Check
*/
if (argument0 == Item.FEATHER && !jumping) {
  audio_play_sound(sndJump, 10, false); //Play the Jumping sound.
  //If Link isn't in a sideview area...
  if (!global.sideview) {
    zmax = -16; //Prepare Link to go a full tile off of the ground.
  } else {
    //Otherwise, make him go off the ground.
    vspeed = -4.5;
  }
  jumping = true; //Flag as Link as jumping.
  pushing = false; //Unflag Link as pushing.
  climbing = false; //Unflag Link as climbing.
  image_index = 0; //Reset his animation.
  //Now let's update Link's sprite.
  scr_link_sprite_change();
  scr_link_collide(); //Check for collision.
}

/*
if (argument0 == Item.BRACELET) {
	if (!carrying) {
		heldObject = scr_link_ahead_chk(objLiftable, 4);
		if (heldObject == -1) {
			exit;
		}
		carrying = true;
		heldObject.lifted = true;
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
*/