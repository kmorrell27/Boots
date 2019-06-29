event_inherited(); //Call the parent code.

//If Link has picked this up, but hasn't used it yet....
if (got && !used) {
  //Get the L2 Sword.
  if (global.sword < 2) {
    global.sword = 2;
  }
  //Add the item to the inventory if it isn't there already.
  scr_add_inventory_item(Item.SWORD);
  //Now flag this item as having been used.
  used = true;
}
