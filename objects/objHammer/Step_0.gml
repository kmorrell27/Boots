event_inherited(); //Call the parent event.

//Temporary variable for Link's animation image.
var quartersecond = global.onesecond / 4;
var img = floor(
  (quartersecond - objPlayer.alarm[0]) /
    (quartersecond / objHammer.image_number)
);

//Hammering checking.
if (objPlayer.hammering) {
  //If the subimage has changed...
  if (lastimg < img) {
    //Store the previous X and Y offsets, and image.
    lastxoff = xoff;
    lastyoff = yoff;
    lastimg = img;
  }

  /*
    This if-else tree positions the sword based on Link's current
    frame in his animation.  It will always be in his hand, minus
    the mid-slash frame.
    */
  if (img == 0) {
    //First Frame.
    if (objPlayer.dir == Direction.DOWN) {
      xoff = 3;
      yoff = 3;
      depth = objPlayer.depth - 1;
    } else if (objPlayer.dir == Direction.UP) {
      xoff = -4;
      yoff = -1;
      depth = objPlayer.depth + 1;
    } else if (objPlayer.dir == Direction.LEFT) {
      xoff = -3;
      yoff = -4;
      depth = objPlayer.depth + 1;
    } else {
      xoff = 3;
      yoff = 0;
      depth = objPlayer.depth - 1;
    }
  } else if (img == 1) {
    //Second Frame
    if (objPlayer.dir == Direction.DOWN) {
      xoff = 3;
      yoff = 10;
      depth = objPlayer.depth - 1;
    } else if (objPlayer.dir == Direction.UP) {
      xoff = -4;
      yoff = -10;
      depth = objPlayer.depth + 1;
    } else if (objPlayer.dir == Direction.LEFT) {
      xoff = -10;
      yoff = -4;
      depth = objPlayer.depth + 1;
    } else {
      xoff = 10;
      yoff = 0;
      depth = objPlayer.depth - 1;
    }
  } else {
    //Last Frames
    if (objPlayer.dir == Direction.DOWN) {
      xoff = 3;
      yoff = 14;
      depth = objPlayer.depth - 1;
    } else if (objPlayer.dir == Direction.UP) {
      xoff = -4;
      yoff = -13;
      depth = objPlayer.depth + 1;
    } else if (objPlayer.dir == Direction.LEFT) {
      xoff = -14;
      yoff = -4;
      depth = objPlayer.depth + 1;
    } else {
      xoff = 14;
      yoff = 0;
      depth = objPlayer.depth - 1;
    }
  }
}

/*
If the animation frame is on the slash frame, the mask should be
considered as a whole tile.  This is so the slash doesn't have
to be pixel perfect.  Otherwise, it should be the same as the sword
sprite itself.
*/
if (img >= 2) {
  mask_index = spr16x16Mask;
} else {
  mask_index = -1;
}

hspeed = objPlayer.hspeed; //Have the same horizontal velocity as Link.
vspeed = objPlayer.vspeed; //Have the same vertical velocity as Link.
x = objPlayer.x + objPlayer.xoff + xoff; //Go to Link's X spot with the needed offset.
y = objPlayer.y + objPlayer.yoff + yoff; //Go to Link's Y spot with the needed offset.
z = objPlayer.z; //Same distance off of the ground as Link.
