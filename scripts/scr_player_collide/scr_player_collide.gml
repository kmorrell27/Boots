/********************************************************************
This is Link's collision checking script for solid objects.
********************************************************************/

//If there is a wall where Link is heading vertically...
if (!place_free(x, y + vspeed)) {
  /*
    Conserve the force Link had in the vertical direction.  Only
    apply if this isn't a sidescrolling area, or if it's Link
    sliding against the ceiling.
    */
  if (!global.sideview || (global.sideview && vspeed < 0)) {
    vvel = vspeed;
  }
  //If he's going up...
  if (vspeed < 0) {
    //Hug the wall just above him.
    move_contact_solid(90, 4);
    //If he somehow got in the wall, get out of it.
    move_outside_solid(270, 1);
  } else if (vspeed > 0) {
    //Otherwise, hug the wall just below him.
    move_contact_solid(270, 4);
    //If he somehow got in the wall, get out of it.
    move_outside_solid(90, 1);
  }
  vspeed = 0;
  //Reset his actual vertical speed.
}

//If there is a wall where Link is heading horizontally...
if (!place_free(x + hspeed, y)) {
  //Conserve the force Link had in the horizontal direction.
  hvel = hspeed;
  //If he's going left...
  if (hspeed < 0) {
    //Hug the wall just to the left of him.
    move_contact_solid(180, 4);
    //If he somehow got in the wall, get out of it.
    move_outside_solid(360, 1);
  } else if (hspeed > 0) {
    //Otherwise, hug the wall just to the right of him.
    move_contact_solid(360, 4);
    //If he somehow got in the wall, get out of it.
    move_outside_solid(180, 1);
  }
  hspeed = 0;
  //Reset his actual horizontal speed.
}
