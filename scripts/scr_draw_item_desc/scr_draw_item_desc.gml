/*********************************************************************
This script draws the sprite and description of the item.

format:  scr_draw_item_desc(item,xpos,ypos,blend,alpha);
*********************************************************************/

//If there isn't an item to draw, then get out of this script.
if (argument0 == noone || argument0 == "0" || argument0 == " ") {
  exit;
}

/*
First, make a temporary variable for which sprite we'll be using.
Then make another for which subimage to use.  Make one more for
the text description.
*/
var spr = sprInvis;
var img = -1;
var text = "";

//Sword Check
if (argument0 == Item.SWORD) {
  spr = sprHUDSword;
  img = global.sword - 1;

  if (global.sword == 1) {
    text = "Fighter's Sword";
  } else if (global.sword == 2) {
    text = "Master Sword";
  } else if (global.sword == 3) {
    text = "Tempered Sword";
  } else if (global.sword == 4) {
    text = "Golden Sword";
  }
}

//Shield Check
if (argument0 == Item.SHIELD) {
  spr = sprHUDShield;
  img = global.shield - 1;

  if (global.shield == 1) {
    text = "Fighter's Shield";
  } else if (global.shield == 2) {
    text = "Red Shield";
  } else if (global.shield == 3) {
    text = "Mirror Shield";
  }
}

//Bombs Check
if (argument0 == Item.BOMB) {
  spr = sprHUDBomb;
  img = global.bombtype;

  if (global.bombtype == 0) {
    text = "Bombs x" + string(global.bombs);
  } else if (global.bombtype == 1) {
    text = "Silver Bombs x" + string(global.bombs);
  } else if (global.bombtype == 2) {
    text = "Golden Bombs x" + string(global.bombs);
  }
}

//Rocs Check
if (argument0 == Item.FEATHER) {
  spr = sprHUDFeather;
  img = global.feather - 1;

  if (global.feather == 1) {
    text = "Roc's Feather";
  } else if (global.feather == 2) {
    text = "Roc's Cape";
  }
}

//Bracelet Check
if (argument0 == Item.BRACELET) {
  spr = sprHUDBracelet;
  img = global.bracelet - 1;

  if (global.bracelet == 1) {
    text = "Power Bracelet";
  } else if (global.bracelet == 2) {
    text = "Titan's Glove";
  }
}

//Shovel Check
if (argument0 == Item.SHOVEL) {
  spr = sprHUDShovel;
  img = global.shovel - 1;

  if (global.shovel == 1) {
    text = "Shovel";
  } else if (global.shovel == 2) {
    text = "Golden Shovel";
  }
}

/*
Finally, draw the description.  Then draw the sprite needed with the
required image at the given location with the required formatting
right next to it.
*/
scr_outline_text(
  argument1 + 8,
  argument2 + 4,
  text,
  CL_WHITE,
  CL_BLACK,
  argument4
);
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
