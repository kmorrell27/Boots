/*******************************************************************
This script changes Link's sprite depending on which actions he is
currently performing.  The "global.tunic" variable is added to the
execute_string() functions to give Link the correct sprite based on
which tunic he is wearing.  Since Game Maker doesn't support palettes,
this is the only way to accomplish this; making separate sprites for
each costume you want Link to have.
*******************************************************************/

var dirString = scr_get_direction(dir);

//If Link doesn't have the shield equipped, the shield isn't visible.
if (!scr_check_equipped(Item.SHIELD)) {
  shieldspr = sprInvis;
}

//If Link isn't doing anything specific...
if (
  pushtmr < global.onesecond / 4 &&
  !digging &&
  !holding &&
  !rolling &&
  !slashing &&
  !charge &&
  !jumping
) {
  /*
    If Link isn't flagged as isMoving, use his idle sprites.  Otherwise,
    use his walking sprites.
    */
  

  if (!isMoving) {
    if (!defend) {
      if (scr_check_equipped(Item.SHIELD)) {
        sprite_index = asset_get_index(
          "sprLink" + string(global.tunic) + "HSI" + dirString
        );
        shieldspr = asset_get_index(
          "sprShield" + string(global.shield) + "I" + dirString
        );
      } else {
        sprite_index = asset_get_index(
          "sprLink" + string(global.tunic) + "I" + dirString
        );
      }
    } else {
      sprite_index = asset_get_index(
        "sprLink" + string(global.tunic) + "USI" + dirString
      );
      shieldspr = asset_get_index(
        "shieldspr" + string(global.shield) + "UI" + dirString
      );
    }
  } else {
    if (!defend) {
      if (scr_check_equipped(Item.SHIELD)) {
        sprite_index = asset_get_index(
          "sprLink" + string(global.tunic) + "HSW" + dirString
        );
        shieldspr = asset_get_index(
          "sprShield" + string(global.shield) + "W" + dirString
        );
      } else {
        sprite_index = asset_get_index(
          "sprLink" + string(global.tunic) + "W" + dirString
        );
        shieldspr = sprInvis;
      }
    } else {
      sprite_index = asset_get_index(
        "sprLink" + string(global.tunic) + "USW" + dirString
      );
      shieldspr = asset_get_index(
        "shieldSpr" + string(global.shield) + "U" + dirString
      );
    }
  }
} else if (
  pushtmr >= global.onesecond / 4 &&
  !digging &&
  !rolling &&
  !holding &&
  !slashing &&
  !charge &&
  !jumping
) {
  /*
    Otherwise, if Link is specifically pushing, use his pushing
    sprites.
    */
  sprite_index = asset_get_index("sprLink" + string(global.tunic) + "P" + dirString);
  shieldspr = sprInvis;
} else if (
  digging &&
  !holding &&
  !rolling &&
  !slashing &&
  !charge &&
  !jumping
) {
  /*
    Otherwise, if Link is specifically digging, use his digging
    sprites.
    */
  sprite_index = asset_get_index("sprLink" + string(global.tunic) + "D" + dirString);
  shieldspr = sprInvis;
} else if (slashing && !holding && !charge) {
  /*
    Otherwise if Link is specifically slashing his sword
    */
  sprite_index = asset_get_index("sprLink" + string(global.tunic) + "S" + dirString);
  shieldspr = sprInvis;
} else if (charge && !holding) {
  /*
    Otherwise if Link is specifically charging his sword
    */
  sprite_index = asset_get_index("sprLink" + string(global.tunic) + "CH" + dirString);
  shieldspr = sprInvis;
} else if ((jumping || rolling) && !holding) {
  /*
    Otherwise if Link is specifically jumping or rolling, use his
    jumping sprites.
    */
  sprite_index = asset_get_index("sprLink" + string(global.tunic) + "J" + dirString);
  shieldspr = sprInvis;
} else if (holding) {
  /*
    Otherwise if Link is specifically holding up an item, use his
    holding up sprite.
    */
  sprite_index = asset_get_index(
    "sprLink" + string(global.tunic) + "H" + string(holding)
  );
  /*
    If Link is only using one hand, change the shield sprite to
    the shield sprite used for holding up an item.  Otherwise
    don't draw the shield.
    */
  if (holding == 1 && scr_check_equipped(Item.SHIELD)) {
    shieldspr = asset_get_index("sprShield" + string(global.shield) + "H");
  } else {
    shieldspr = sprInvis;
  }
}
