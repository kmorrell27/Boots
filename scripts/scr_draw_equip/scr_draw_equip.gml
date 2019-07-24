/*********************************************************************
This script draws the sprite and level number/counter, if applicable,
of the equipment.

format:  scr_draw_button_item(item,xpos,ypos,blend,alpha);
*********************************************************************/

//If there isn't an item to draw, then get out of this script.
if (argument0 == noone || argument0 == "0" || argument0 == " ") {
  exit;
}

/*
First, make a temporary variable for which sprite we'll be using.
Then make another for which subimage to use.
*/
var spr = sprInvis;
var img = -1;

//Sword Check
if (argument0 == Item.SWORD) {
  spr = sprHUDSword;
  img = global.sword - 1;
  scr_draw_level_number(
    global.sword,
    argument1 + 8,
    argument2 + 8,
    argument3,
    argument4
  );
}

//Shield Check
if (argument0 == Item.SHIELD) {
  spr = sprHUDShield;
  img = global.shield - 1;
  scr_draw_level_number(
    global.shield,
    argument1 + 8,
    argument2 + 8,
    argument3,
    argument4
  );
}

//Bombs Check
if (argument0 == Item.BOMB) {
  var blend = CL_WHITE;

  /*
    If Link has no ammunition, draw the digits with a gray color.
    Otherwise, if he has full ammunition, draw them with a yellow
    color.
    */
  if (global.bombs == 0) {
    blend = CL_GRAY;
  } else if (global.bombs == global.bombmax[global.bombbag]) {
    blend = CL_YELLOW;
  }

  spr = sprHUDBomb;
  img = global.bombtype;
  scr_draw_counter(global.bombs, 2, argument1 + 8, argument2, blend, argument4);
  scr_draw_level_number(
    global.bombtype + 1,
    argument1 + 8,
    argument2 + 8,
    argument3,
    argument4
  );
}

//Rocs Check
if (argument0 == Item.FEATHER) {
  spr = sprHUDFeather;
  img = global.feather - 1;
  scr_draw_level_number(
    global.feather,
    argument1 + 8,
    argument2 + 8,
    argument3,
    argument4
  );
}

//Bracelet Check
if (argument0 == Item.BRACELET) {
  spr = sprHUDBracelet;
  img = global.bracelet - 1;
  scr_draw_level_number(
    global.bracelet,
    argument1 + 8,
    argument2 + 8,
    argument3,
    argument4
  );
}

/*
Finally, draw the sprite needed with the required image at the
given location with the required formatting.
*/
draw_sprite_ext(
  spr,
  img,
  argument1,
  argument2,
  image_xscale,
  image_yscale,
  image_angle,
  argument3,
  argument4
);
