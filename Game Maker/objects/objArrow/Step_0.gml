//If the game is paused, get out of this script.
if (scr_pause_check()) {
  exit;
}

//Movement for the Down direction.
if (dir == Direction.DOWN) {
  //If there isn't a wall, move.  Otherwise, collide and delete.
  if (!collision_rectangle(x + 4, y, x + 6, y + 16, objSolid, false, true)) {
    y += spd;
  } else {
    move_contact_solid(270, -1);
    instance_destroy();
  }
}

//Movement for the Up direction.
if (dir == Direction.UP) {
  //If there isn't a wall, move.  Otherwise, collide and delete.
  if (!collision_rectangle(x + 4, y, x + 6, y + 16, objSolid, false, true)) {
    y -= spd;
  } else {
    move_contact_solid(90, -1);
    instance_destroy();
  }
}

//Movement for the Left direction.
if (dir == Direction.LEFT) {
  //If there isn't a wall, move.  Otherwise, collide and delete.
  if (!collision_rectangle(x, y + 4, x + 16, y + 6, objSolid, false, true)) {
    x -= spd;
  } else {
    move_contact_solid(180, -1);
    instance_destroy();
  }
}

//Movement for the Right direction.
if (dir == Direction.RIGHT) {
  //If there isn't a wall, move.  Otherwise, collide and delete.
  if (!collision_rectangle(x, y + 4, x + 16, y + 6, objSolid, false, true)) {
    x += spd;
  } else {
    move_contact_solid(360, -1);
    instance_destroy();
  }
}
