event_inherited(); //Call the parent event.
interactdir = Direction.UP; //Link has to face up to open this chest.

image_speed = 0; //No animation speed for you!
//Which chest is this?  -1 for a respawning chest upon leaving.
chestnum = -1;
opened = false; //Has this chest been opened yet?
itemobj = noone; //Which item to give Link.
itemspr = sprItemRupee; //What sprite to draw as the chest is being opened.
itemalpha = 0; //How transparent the item sprite is drawn.
/*
How long this chest has, in frames, before the item is no longer drawn
above it, and the item is given to Link.
*/
opentmr = global.onesecond;
drawy = 0; //Where is the item being drawn?
/*
Check to see if the chest has been opened now.  If it has, flag
this chest as having been opened, and set the image appropriately.
Finally, consider it as interacted.
*/
if (chestnum > -1) {
  if (global.chest[chestnum]) {
    opened = true;
    image_index = 1;
    opentmr = 0;
    interacted = true;
  }
}
