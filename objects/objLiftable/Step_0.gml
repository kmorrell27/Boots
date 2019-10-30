event_inherited();
if (pushspd != 0) {
  // We're pushing so it can't be lifted
  exit;
}
if (!lifted && !thrown) {
  // We're all good.
  exit;
} else if (lifted && !thrown) {
  //Just carrying
  x = objPlayer.x;
  y = objPlayer.y;
  z = -16;
  solid = false;
}
if (thrown && !global.sideview) {
  /*
    If the height hasn't peaked yet, the zspd should be smaller the
    closer it gets to its peak.  Otherwise it should be larger as
    it approaches the ground.
    */
  zspd = max(abs(floor(round((zmax - z) / 3))), 1);

  /*
    If it hasn't peaked in height yet, subtract the zspd
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
      throwx = 0;
      throwy = 0;
      throwspd = 0;
      zpeak = false;
      zmax = 0;
      thrown = false;
      audio_play_sound(sndLand, 10, false);
      if (!durable) {
        instance_destroy();
      }
    }
  }
  if (throwx != 0) {
    x += throwspd;
    throwx -= throwspd;
  }
  if (throwy != 0) {
    y += throwspd;
    throwy -= throwspd;
  }
  if (place_meeting(x, y, objSolid)) {
    if (!durable) {
      if (throwx != 0) {
        xoff = throwx > 0 ? 0 : -12;
      }
      if (throwy != 0) {
        xoff = -4;
        yoff = throwy > 0 ? 16 : 0;
      }
      instance_destroy();
    } else {
      // bounce!
      throwx *= -1;
      throwy *= -1;
      throwspd *= -1;
    }
  }
}
