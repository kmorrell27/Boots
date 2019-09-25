event_inherited(); //Call the parent event.

//Temporary variable for Link's animation image.
var img = floor(objLink.image_index);

//Slashing checking.
if (objLink.slashing) {
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
    if (objLink.dir == Direction.DOWN) {
      xoff = -11;
      yoff = 3;
      depth = objLink.depth - 1;
    } else if (objLink.dir == Direction.UP) {
      xoff = 13;
      yoff = -1;
      depth = objLink.depth + 1;
    } else if (objLink.dir == Direction.LEFT) {
      xoff = -3;
      yoff = -13;
      depth = objLink.depth + 1;
    } else {
      xoff = 3;
      yoff = -13;
      depth = objLink.depth + 1;
    }
  } else if (img == 1) {
    //Second Frame
    if (objLink.dir == Direction.DOWN) {
      xoff = -8;
      yoff = 10;
      depth = objLink.depth - 1;
    } else if (objLink.dir == Direction.UP) {
      xoff = 8;
      yoff = -10;
      depth = objLink.depth + 1;
    } else if (objLink.dir == Direction.LEFT) {
      xoff = -10;
      yoff = -8;
      depth = objLink.depth + 1;
    } else {
      xoff = 10;
      yoff = -8;
      depth = objLink.depth + 1;
    }
  } else {
    //Last Frames
    if (objLink.dir == Direction.DOWN) {
      xoff = 3;
      yoff = 14;
      depth = objLink.depth - 1;
    } else if (objLink.dir == Direction.UP) {
      xoff = -4;
      yoff = -13;
      depth = objLink.depth + 1;
    } else if (objLink.dir == Direction.LEFT) {
      xoff = -14;
      yoff = 4;
      depth = objLink.depth - 1;
    } else {
      xoff = 14;
      yoff = 4;
      depth = objLink.depth - 1;
    }
  }
} else if (objLink.charge) {
  //Charge Checking.
  if (objLink.dir == Direction.DOWN) {
    xoff = 3;
    yoff = 14;
    depth = objLink.depth - 1;
  } else if (objLink.dir == Direction.UP) {
    xoff = -4;
    yoff = -13;
    depth = objLink.depth + 1;
  } else if (objLink.dir == Direction.LEFT) {
    xoff = -14 + 1 * (img == 1);
    yoff = 4;
    depth = objLink.depth - 1;
  } else {
    xoff = 14 - 1 * (img == 1);
    yoff = 4;
    depth = objLink.depth - 1;
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

//If Link isn't charging.
if (!objLink.charge) {
  //Use the same animation frame as Link.
  image_index = objLink.image_index;
} else {
  //Use the last image index.
  image_index = 3;
}

hspeed = objLink.hspeed; //Have the same horizontal velocity as Link.
vspeed = objLink.vspeed; //Have the same vertical velocity as Link.
x = objLink.x + objLink.xoff + xoff; //Go to Link's X spot with the needed offset.
y = objLink.y + objLink.yoff + yoff; //Go to Link's Y spot with the needed offset.
z = objLink.z; //Same distance off of the ground as Link.
