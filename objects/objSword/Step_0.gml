event_inherited(); //Call the parent event.

//Temporary variable for the player's animation image.
var quartersecond = global.onesecond / 4;
var img = floor(
  (quartersecond - global.playerid.alarm[0]) /
    (quartersecond / objSword.image_number)
);

//Slashing checking.
if (global.playerid.slashing) {
  //If the subimage has changed...
  if (lastimg < img) {
    //Store the previous X and Y offsets, and image.
    lastxoff = xoff;
    lastyoff = yoff;
    lastimg = img;
  }

  /*
    This if-else tree positions the sword based on the player's current
    frame in their animation.  It will always be in their hand, minus
    the mid-slash frame.
    */
  if (img == 0) {
    //First Frame.
    if (global.playerid.dir == Direction.DOWN) {
      xoff = -11;
      yoff = 3;
      depth = global.playerid.depth - 1;
    } else if (global.playerid.dir == Direction.UP) {
      xoff = 13;
      yoff = -1;
      depth = global.playerid.depth + 1;
    } else if (global.playerid.dir == Direction.LEFT) {
      xoff = -3;
      yoff = -13;
      depth = global.playerid.depth + 1;
    } else {
      xoff = 3;
      yoff = -13;
      depth = global.playerid.depth + 1;
    }
  } else if (img == 1) {
    //Second Frame
    if (global.playerid.dir == Direction.DOWN) {
      xoff = -8;
      yoff = 10;
      depth = global.playerid.depth - 1;
    } else if (global.playerid.dir == Direction.UP) {
      xoff = 8;
      yoff = -10;
      depth = global.playerid.depth + 1;
    } else if (global.playerid.dir == Direction.LEFT) {
      xoff = -10;
      yoff = -8;
      depth = global.playerid.depth + 1;
    } else {
      xoff = 10;
      yoff = -8;
      depth = global.playerid.depth + 1;
    }
  } else {
    //Last Frames
    if (global.playerid.dir == Direction.DOWN) {
      xoff = 3;
      yoff = 14;
      depth = global.playerid.depth - 1;
    } else if (global.playerid.dir == Direction.UP) {
      xoff = -4;
      yoff = -13;
      depth = global.playerid.depth + 1;
    } else if (global.playerid.dir == Direction.LEFT) {
      xoff = -14;
      yoff = 4;
      depth = global.playerid.depth - 1;
    } else {
      xoff = 14;
      yoff = 4;
      depth = global.playerid.depth - 1;
    }
  }
} else if (global.playerid.charge) {
  //Charge Checking.
  if (global.playerid.dir == Direction.DOWN) {
    xoff = 3;
    yoff = 14;
    depth = global.playerid.depth - 1;
  } else if (global.playerid.dir == Direction.UP) {
    xoff = -4;
    yoff = -13;
    depth = global.playerid.depth + 1;
  } else if (global.playerid.dir == Direction.LEFT) {
    xoff = -14 + 1 * (img == 1);
    yoff = 4;
    depth = global.playerid.depth - 1;
  } else {
    xoff = 14 - 1 * (img == 1);
    yoff = 4;
    depth = global.playerid.depth - 1;
  }
}

/*
If the animation frame is on the slash frame, the mask should be
considered as a whole tile.  This is so the slash doesn't have
to be pixel perfect.  Otherwise, it should be the same as the sword
sprite itself.
*/
if (img == 1) {
  mask_index = spr16x16Mask;
} else {
  mask_index = sprite_index;
}

//If the player isn't charging.
if (!global.playerid.charge) {
  //Use the same animation frame as the player.
  image_index = img;
} else {
  //Use the last image index.
  image_index = 3;
}

hspeed = global.playerid.hspeed; //Have the same horizontal velocity as the player.
vspeed = global.playerid.vspeed; //Have the same vertical velocity as the player.
x = global.playerid.x + global.playerid.xoff + xoff; //Go to the player's X spot with the needed offset.
y = global.playerid.y + global.playerid.yoff + yoff; //Go to the player's Y spot with the needed offset.
z = global.playerid.z; //Same distance off of the ground as the player.
