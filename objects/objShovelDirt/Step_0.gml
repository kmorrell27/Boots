event_inherited(); //Call the parent script.

//If the game is paused, break out of this script.
if (scr_pause_chk()) {
  exit;
}

// If this object still has some air climbing to do...
if (zmax < 0) {
  /*
    If the object hasn't peaked yet, the zspd should be smaller the
    closer it gets to its peak.  Otherwise it should be larger as
    it approaches the ground.
    */
  zspd = max(abs(round((zmax - z) / 3)), 1);
  
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
    if (z + zspd <= 0) {
      z += zspd;
    } else {
      z = 0;
      zpeak = true;
    }
    
    //Slowly fade away, now that the object went all the way up.
    image_alpha -= 0.1;
    
    //If it's completely faded, then delete itself.
    if (image_alpha <= 0) {
      instance_destroy();
    }
  }
}

/* */
/*  */
