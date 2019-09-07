/*********************************************************************
This script draws the pause menu.

format:  scr_draw_menu(xpos,ypos,alpha);
*********************************************************************/

/*
Temporary variable for the y offset of where to draw the hud, based
on the anchor.  If it's negative, then it'll start from the bottom.
Otherwise, it'll start from the top.
*/
var yoff = -128 + 8 * global.menuanchor + 272 * (global.menuanchor < 0);

//Draw the background of the menu first.
draw_sprite_ext(
  sprMenu,
  -1,
  argument0,
  argument1 + yoff,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  argument2
);

//Temporary variables for the offset of each inventory item.
var xshift = 0;
var yshift = 0;

//Now loop through and draw the inventory equipment.
for (var inven = 0; inven < 30; inven += 1) {
  //Update the offset base on which slot the loop is on.
  xshift = inven * 40 - (inven div 6) * 120;
  yshift = (inven div 6) * 16;
  
  //Now draw the item and it's level/counter.
  scr_draw_equip(
    global.inventory[inven],
    argument0 + 24 + xshift,
    argument1 + yoff + 8 + yshift,
    image_blend,
    argument2
  );
}

//Now draw the cursor.
draw_sprite_ext(
  sprMenuSelector,
  -1,
  argument0 + 16 + global.menucurx,
  argument1 + 8 + global.menucury + yoff,
  image_xscale,
  image_yscale,
  image_angle,
  image_blend,
  argument2
);

//Finally draw the item description of the item the cursor is over.
scr_draw_item_desc(
  global.inventory[global.menupos],
  argument0 + 8,
  argument1 + yoff + 104,
  image_blend,
  argument2
);
