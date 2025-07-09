event_inherited(); //Call the parent event.
z = 0; //How far off of the ground is this?
xoff = 0; //The X offset from the player's position.
yoff = 0; //The Y offset from the player's position.
lastxoff = 0; //Previous X offset.
lastyoff = 0; //Previous Y offset.
lastimg = -1; //Previous image frame.
damage = 1;
switch (global.playerid.dir) {
  case Direction.DOWN:
    sprite_index = sprSwordDown;
    break;
  case Direction.LEFT:
    sprite_index = sprSwordLeft;
    break;
  case Direction.RIGHT:
    sprite_index = sprSwordRight;
    break;
  case Direction.UP:
    sprite_index = sprSwordUp;
    break;
}
