event_inherited(); //Call the parent code.

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Get the L3 Shield.
  if (global.shield < 3) {
    global.shield = 3;
  }
  //Add the item to the inventory if it isn't there already.
  scr_add_inventory_item(Item.SHIELD);
  //Now flag this item as having been used.
  used = true;
}
