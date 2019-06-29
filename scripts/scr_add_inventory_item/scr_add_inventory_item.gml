/*********************************************************************
This script adds the given parameter to either a free button item slot,
or in the inventory, if it doesn't already exist.

format:  scr_add_inventory_item(item);
*********************************************************************/

//Temporary variable to check if the item was already located.
var found = false;

//If Link has the item equipped, then he has it.
if (global.Z == argument0 || global.X == argument0) {
  found = true;
}

//Check to see if the item is found in the inventory already.
for (var invenchk = 0; invenchk < 15 && !found; invenchk += 1) {
  if (global.inventory[invenchk] == argument0) {
    found = true;
  }
}

//If Link doesn't already have the item...
if (!found) {
  //If there's nothing on Z, put it there.
  if (global.Z == noone) {
    global.Z = argument0;
  } else if (global.X == noone) {
    //Otherwise, if there's nothing on X, put it there.
    global.X = argument0;
  } else {
    //Otherwise, put it on the next empty space in the inventory.
    for (var invenadd = 0; invenadd < 15; invenadd += 1) {
      if (global.inventory[invenadd] == noone) {
        global.inventory[invenadd] = argument0;
        break;
      }
    }
  }
}
