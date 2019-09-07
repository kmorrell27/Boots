/*******************************************************************
This script creates a random item drop at the given x and y
location, and returns the ID of that object.

format:  scr_random_item(xpos,ypos);
********************************************************************/
//Setup the base cases.
var itemtype = objItemRupee;
itemchose = irandom(2);

if (itemchose == 0) {
  //Make it a Heart.
  itemtype = objItemHeart;
} else if (itemchose == 1) {
  //Make it a Blue Rupee.
  itemtype = objItemBlueRupee;
}

return instance_create_layer(argument0, argument1, global.playerLayer, itemtype);
