function scr_player_collide() {
  /********************************************************************
	This is the player's collision checking script for solid objects.
	********************************************************************/

  //If there is a wall where the player is heading vertically...
  if (!place_free(x, y + vspeed)) {
    /*
	    Conserve the force the player had in the vertical direction.  Only
	    apply if this isn't a sidescrolling area, or if it's the player
	    sliding against the ceiling.
	    */
    if (!global.sideview || (global.sideview && vspeed < 0)) {
      vvel = vspeed;
    }
    //If they're going up...
    if (vspeed < 0) {
      //Hug the wall just above them.
      move_contact_solid(90, 4);
      //If they somehow got in the wall, get out of it.
      move_outside_solid(270, 1);
    } else if (vspeed > 0) {
      //Otherwise, hug the wall just below them.
      move_contact_solid(270, 4);
      //If they somehow got in the wall, get out of it.
      move_outside_solid(90, 1);
    }
    vspeed = 0;
    //Reset their actual vertical speed.

    // And they can't run anymore
    running = false;
  }

  //If there is a wall where the player is heading horizontally...
  if (!place_free(x + hspeed, y)) {
    //Conserve the force the player had in the horizontal direction.
    hvel = hspeed;
    //If they're going left...
    if (hspeed < 0) {
      //Hug the wall just to the left of them.
      move_contact_solid(180, 4);
      //If they somehow got in the wall, get out of it.
      move_outside_solid(360, 1);
    } else if (hspeed > 0) {
      //Otherwise, hug the wall just to the right of them.
      move_contact_solid(360, 4);
      //If they somehow got in the wall, get out of it.
      move_outside_solid(180, 1);
    }
    hspeed = 0;
    //Reset their actual horizontal speed.

    running = false;
  }
}
