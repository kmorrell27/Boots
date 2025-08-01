if (scr_pause_check()) {
  exit;
}

//If it is raining, go in here.
if (global.rain) {
  //If it's thundering, go in here.
  if (thunder) {
    /*
        If the the thunder fading isn't fading out, make it more
        visible until maximum.  Once it reaches maximum, flip the
        thunder fading to reverse gear and start fading out.
        Once it finishes fading out, thundering should be unflagged.
        */
    if (!thunderpoint) {
      thunderalpha += 0.125;
      if (thunderalpha >= 0.5) {
        thunderpoint = true;
      }
    } else {
      thunderalpha -= 0.125;
      if (thunderalpha <= 0) {
        thunder = false;
      }
    }
  } else {
    //Otherwise, do this stuff.

    thunderpoint = false;
    //Reset the thunder fade position.
    thunderalpha = 0;
    //Reset the thunder alpha.
  }

  /*
    If there is a delay on the thunder, subtract a frame.
    Otherwise, play the sound, turn the thunder on, and give
    the delay on the next thunder a random amount of frames.
    */
  if (thunderdly) {
    thunderdly -= 1;
  } else {
    //audio_play_sound(sndThunder, 10, false);
    thunder = true;
    thunderdly = irandom(global.onesecond * 5.5) + global.onesecond / 2;
  }
} else {
  //Otherwise, do this stuff.

  thunder = false;
  //Reset the thunder.
  thunderpoint = false;
  //Reset the thunder fade position.
  thunderalpha = 0;
  //Reset the thunder alpha.
  thunderdly = global.onesecond * 1.5;
  //Reset the thunder delay.
}
