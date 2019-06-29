/*********************************************************************
This script is called when a button item is pressed.  Link needs to
use the item, if possible, and if he isn't already doing something.

format:  scr_use_item(item);
*********************************************************************/

/*
If Link isn't in a state to use an item, then get out of here.
*/
if (!moveable || digging || slashing || cliff || rolling) {
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
  defend = false; //Unflag Link as defending.
  pushing = false; //Unflag Link as pushing.
  image_index = 0; //Reset his animation.
  s = instance_create_layer(x, y, global.playerLayer, objSword); //Create the sword.
  //Now give it the proper sprite based on which sword Link has.
  s.sprite_index = asset_get_index(
    "sprSword" + string(global.sword) + "S" + dir
  );
  //Now let's update Link's sprite.
  scr_link_sprite_change();
}

/*
Shield Check
*/
if (argument0 == Item.SHIELD && !defend && !jumping && !charge && !spin) {
  audio_play_sound(sndShield, 10, false); //Play the shield use sound.
  defend = true; //Flag Link as defending.
  pushing = false; //Unflag Link as pushing.
  //Update Link's current sprites.
  scr_link_sprite_change();
}

/*
Shovel Check
*/
if (argument0 == Item.SHOVEL && !jumping && !charge && !spin) {
  var ground = layer_get_id(global.groundLayer);
  var underground = layer_get_id(global.undergroundLayer);
  if (ground == -1 || underground == -1) {
	  exit;
  }
  var soundplay = false;
  var groundTile = layer_tilemap_get_id(ground);
  var undergroundTile = layer_tilemap_get_id(underground);
  var tlower = tilemap_get_at_pixel(groundTile, x + 8, y + 8);
  var tupper = tilemap_get_at_pixel(undergroundTile, x + 8, y + 8);

  /*
            If the tiles exist, delete the upper one and play the digging
            sound.  Otherwise, play the clanking sound for failure.
            */
  if (layer_tile_exists(tlower) && layer_tile_exists(tupper)) {
    //Store the x and y locations of the tile.
    var tilex = layer_tile_get_x(tupper);
    var tiley = layer_tile_get_y(tupper);

    //If there isn't a solid where this is at.
    if (place_free(tilex, tiley)) {
      layer_tile_destroy(tupper); //Delete the upper tile.
      soundplay = true; //Schedule the digging sound.

      /*
                    Temporary variable for the ID of the dirt effects that
                    are going to be made.
                    */
      var dirt = -1;

      /*
                    Now create the dirt flying effect twice at Link's positon,
                    giving each velocity based on which one it is, and Link's
                    facing direction.
                    */
      for (i = 0; i < 2; i += 1) {
        dirt = instance_create_layer(
          tilex + 4,
          tiley + 4,
          global.playerLayer,
          objShovelDirt
        );
        if (dir == Direction.DOWN || dir == Direction.UP) {
          dirt.hspeed = -1 + 2 * i;
          dirt.vspeed = 1 - 2 * (dir == Direction.UP);
        } else {
          dirt.hspeed = 1 - 2 * (dir == Direction.LEFT);
          dirt.vspeed = -1 + 2 * i;
        }
      }

      //1 in 8 Chance to dig up an item.
      if (irandom(8) == 1) {
        /*
                        Temporary variables for the item type to get, the random
                        choosing of an item, and the ID of the actual object made.
                        */
        var itemtype = objItemRupee;
        var itemchose = irandom(2);
        var item = -1;

        /*
                        This is looped based on the shovel level.  The Golden
                        Shovel (Level 2) yields 2 items at once, though
                        they won't always be the same item.
                        */
        for (i = 0; i < global.shovel; i += 1) {
          //Setup the base cases.
          itemtype = objItemRupee;
          itemchose = irandom(2);
          item = -1;

          if (itemchose == 0) {
            //Make it a Heart.
            itemtype = objItemHeart;
          } else if (itemchose == 1) {
            //Make it a Blue Rupee.
            itemtype = objItemBlueRupee;
          }

          /*
                            Create the item, then give it momentum based on the
                            direction Link is facing.
                            */
          item = instance_create_layer(
            tilex + 4,
            tiley + 4,
            global.playerLayer,
            itemtype
          );
          if (dir == Direction.DOWN || dir == Direction.UP) {
            item.vspeed = 4 - 8 * (dir == Direction.UP);
            item.hspeed =
              -1 * (global.shovel == 2 && i == 0) +
              1 * (global.shovel == 2 && i == 1);
          } else {
            item.vspeed =
              -1 * (global.shovel == 2 && i == 0) +
              1 * (global.shovel == 2 && i == 1);
            item.hspeed = 4 - 8 * (dir == Direction.LEFT);
          }
        }
        audio_play_sound(sndItemDug, 10, false); //Play the Item Digging sound.
      }
    }
  }

  /*
    Play the digging sound if he managed to dig a tile.  Otherwise
    play the clanking sound.
    */
  if (soundplay) {
    audio_play_sound(sndDig, 10, false);
  } else {
    audio_play_sound(sndClank, 10, false);
  }

  image_index = 0; //Reset Link's animation frame.
  digging = true; //And flag him as digging.
  defend = false; //Unflag Link as defending.
  pushing = false; //Unflag Link as pushing.
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
  defend = false; //Unflag Link as defending.
  pushing = false; //Unflag Link as pushing.
  climbing = false; //Unflag Link as climbing.
  image_index = 0; //Reset his animation.
  //Now let's update Link's sprite.
  scr_link_sprite_change();
  scr_link_collide(); //Check for collision.
}

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
