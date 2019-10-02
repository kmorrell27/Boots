/*******************************************************************
This script makes Link do whatever when an item button is released.

format:  scr_release_button(item);
*******************************************************************/

/*
Sword Check
*/
if (argument0 == Item.SWORD && charge && !tap) {
  if (charge < global.onesecond) {
    //Get rid of the sword.
    with (objSword) {
      instance_destroy();
    }
  } else {
    audio_play_sound(sndSpin, 10, false);
    //Get rid of the sword.
    with (objSword) {
      instance_destroy();
    }
  }
  charge = 0;
  //Unflag Link as charging.
  //Update Link's current sprites.
  scr_player_sprite_change();
}

if (argument0 == Item.BOW) {
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
  //Now let's update Link's sprite.
  image_index = 0;
  shooting = false;
}
