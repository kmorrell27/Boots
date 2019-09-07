/*******************************************************************
This script changes Link's sprite depending on which actions he is
currently performing.  The "global.tunic" variable is added to the
execute_string() functions to give Link the correct sprite based on
which tunic he is wearing.  Since Game Maker doesn't support palettes,
this is the only way to accomplish this; making separate sprites for
each costume you want Link to have.
*******************************************************************/

var dirString = scr_get_direction(dir);

//If Link isn't doing anything specific...
if (
  pushtmr < global.onesecond / 4 &&
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
    sprite_index = asset_get_index(
      "sprLink" + string(global.tunic) + "I" + dirString
    );
  } else {
    sprite_index = asset_get_index(
      "sprLink" + string(global.tunic) + "W" + dirString
    );
  }
} else if (
  pushtmr >= global.onesecond / 4 &&
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
  sprite_index = asset_get_index(
    "sprLink" + string(global.tunic) + "P" + dirString
  );
} else if (slashing && !holding && !charge) {
  /*
    Otherwise if Link is specifically slashing his sword
    */
  sprite_index = asset_get_index(
    "sprLink" + string(global.tunic) + "S" + dirString
  );
} else if (charge && !holding) {
  /*
    Otherwise if Link is specifically charging his sword
    */
  sprite_index = asset_get_index(
    "sprLink" + string(global.tunic) + "CH" + dirString
  );
} else if ((jumping || rolling) && !holding) {
  /*
    Otherwise if Link is specifically jumping or rolling, use his
    jumping sprites.
    */
  sprite_index = asset_get_index(
    "sprLink" + string(global.tunic) + "J" + dirString
  );
} else if (holding) {
  /*
    Otherwise if Link is specifically holding up an item, use his
    holding up sprite.
    */
  sprite_index = asset_get_index(
    "sprLink" + string(global.tunic) + "H" + string(holding)
  );
}
