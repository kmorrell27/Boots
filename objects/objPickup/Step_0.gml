//If the game is paused, do what's in here.
if (scr_pause_chk()) {
  //Conserve any speed on the object.
  if (hspeed != 0) {
    lasthspeed = hspeed;
    hspeed = 0;
  }
  if (vspeed != 0) {
    lastvspeed = vspeed;
    vspeed = 0;
  }
  
  //Conserve the animation speed.
  if (lastanispd == -1) {
    lastanispd = image_speed;
    image_speed = 0;
  }
  
  exit;
  //Break out of this script.
} else {
  /*
    Otherwise, if there's any conserved motion, reapply it to the
    object.
    */
  if (lasthspeed != 0) {
    hspeed = lasthspeed;
    lasthspeed = 0;
  }
  if (lastvspeed != 0) {
    vspeed = lastvspeed;
    lastvspeed = 0;
  }
  
  //If there is conserved animation speed, restore it.
  if (lastanispd != -1) {
    image_speed = lastanispd;
    lastanispd = -1;
  }
}

//If there is still a delay on getting this item, take a frame away.
if (getdly) {
  getdly -= 1;
}

/*
If Link hasn't gotten the item yet, do what's in here.
*/
if (!got) {
  /*
    If there is still a delay before this item can start fading away,
    subtract a frame.  Otherwise, start fading, and when it's
    completely invisible, destroy itself.
    */
  if (!nofade) {
    if (fadedly) {
      fadedly -= 1;
    } else {
      image_alpha -= 0.1;
      if (image_alpha <= 0) {
        instance_destroy();
      }
    }
  }
  
  // If this object still has some air climbing to do...
  if (zmax < 0) {
    /*
        If the object hasn't peaked yet, the zspd should be smaller the
        closer it gets to its peak.  Otherwise it should be larger as
        it approaches the ground.
        */
    zspd = max(abs(floor(round((zmax - z) / 3))), 1);
    
    /*
        If the object hasn't peaked in height yet, subtract the zspd
        from the z value.  Otherwise, add it.
        */
    if (!zpeak) {
      if (z - zspd >= zmax) {
        z -= zspd;
      } else {
        z = zmax;
        zpeak = true;
      }
    } else {
      if (z + zspd <= zmin) {
        z += zspd;
      } else {
        z = zmin;
        zpeak = false;
        
        //If this isn't a flying pickup...
        if (!flying) {
          /*
                    If the object has a little bit of bounce left, then
                    allow for it.  Otherwise, keep it grounded.
                    */
          if (floor(zmax / 2) <= -2) {
            zmax = floor(zmax / 2);
          } else {
            zmax = 0;
          }
        }
      }
    }
  }
  
  /*
    If the object has stored horizontal momentum and can move further
    horizontally in that direction, re-apply that momentum.
    */
  if (place_free(x + hforce, y) && hforce != 0) {
    hspeed = hforce;
    hforce = 0;
  }
  
  /*
    If the object has stored verttical momentum and can move further
    vertically in that direction, re-apply that momentum.
    */
  if (place_free(x, y + vforce) && vforce != 0) {
    vspeed = vforce;
    vforce = 0;
  }
  
  /*
    If the object can't travel further horizontally...
    */
  if (!place_free(x + hspeed, y)) {
    //Store the excess speed.
    hforce = hspeed;
    
    //Get in contact with the nearest wall, based on the sign.
    if (hspeed <= 0) {
      move_contact_solid(180, -1);
    } else {
      move_contact_solid(360, -1);
    }
    
    hspeed = 0;
    //Erase the horizontal speed.
  }
  
  /*
    If the object can't travel further vertically...
    */
  if (!place_free(x, y + vspeed)) {
    //Store the excess speed.
    vforce = vspeed;
    
    //Get in contact with the nearest wall, based on the sign.
    if (vspeed <= 0) {
      move_contact_solid(90, -1);
    } else {
      move_contact_solid(270, -1);
    }
    
    vspeed = 0;
    //Erase the vertical speed.
  }
  
  /*
    The item should appear under Link if he's further down the screen.
    Otherwise, it should appear above him.
    */
  if (objLink.y + 8 < y) {
    depth = objLink.depth - 1;
  } else {
    depth = objLink.depth + 1;
  }
  
  /*
    If Link touches this, or he slashes at it, and there isn't a
    delay on picking it up, then it should be flagged has having
    been gotten.
    */
  if (
    (place_meeting(x, y, objLink) || place_meeting(x, y, objSword)) &&
    !getdly
  ) {
    got = true;
    z = 0;
  }
} else {
  //Otherwise, make the item appear above Link.
  depth = objLink.depth - 1;
  x = objLink.x + 4;
  //Center this on Link X wise.
  y = objLink.y + 4;
  //Center this on Link Y wise.
  hspeed = 0;
  //No horizontal speed.
  hforce = 0;
  //Likewise.
  vspeed = 0;
  //No verrtical speed.
  vforce = 0;
  //Likewise.
  
  /*
    If there is still a delay before this Rotates down to Link,
    subtract a frame. And rise up above Link's head.
    */
  if (gotdly) {
    gotdly -= 1;
    if (z > -16) {
      z -= 2;
    }
  } else {
    //Otherwise, move toward Link, rotate, and shrink.
    if (z < 0) {
      z += 1;
    }
    image_angle += 30;
    image_xscale -= 0.05;
    image_yscale -= 0.05;
    
    //If the item shrunk to oblivion, delete itself.
    if (image_xscale <= 0 && image_yscale <= 0) {
      instance_destroy();
    }
  }
}

/* */
/*  */
