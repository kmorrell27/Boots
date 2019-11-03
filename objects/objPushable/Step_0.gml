//If the game is paused, break out of this script.
if (scr_pause_check()) {
  exit;
}

/*
The movement section of the pushable object.  It is started one Link
has given it a distance to be pushed.
*/
if (pushx != 0 || pushy != 0) {
  /*
    Move 1 pixel per frame.
    */
  pushspd = 1;

  //If the push distances are negative, negate the pushspd.
  if (pushx < 0 || pushy < 0) {
    pushspd *= -1;
  }

  //Horizontal Movement
  if (pushx != 0) {
    /*
        Left movement if the push speed is negative, otherwise the
        movement is Right.
        */
    x += pushspd;
    pushx -= pushspd;
  }

  //Vertical Movement
  if (pushy != 0) {
    /*
        Up movement if the push speed is negative, otherwise the
        movement is Down.
        */
    y += pushspd;
    pushy -= pushspd;
  }

  //Movement Completion
  if (pushx == 0 && pushy == 0) {
    pushdir = noone;
    //It is now no longer pushed in a direction.
    /*
        Take one away from the number of pushes Link can push
        this object now, if applicable, since it's been pushed
        once now.
        */
    if (pushes > 0) {
      pushes -= 1;
    }
  }
} else {
  pushspd = 0;
  //It doesn't have a movement speed if it's not pushed.
}
