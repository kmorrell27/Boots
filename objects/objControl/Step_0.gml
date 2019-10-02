/*
Restart Key F2.  Pressing it will restart the whole game.
*/

if (keyboard_check_pressed(vk_f2)) {
  game_restart();
}

/*
If there is no Link, get out of this code.
*/
if (!instance_exists(objPlayer)) {
  exit;
}

/*
Pause Key Enter (Return).  Pressing it pauses the game.
Pressing it again will close it.  Can only
pause if Link is able to move.
*/

if (scr_pause_button_pressed() && objPlayer.moveable) {
  if (!global.pause) {
    audio_play_sound(sndMenuOpen, 10, false);
  } else {
    audio_play_sound(sndMenuClose, 10, false);
  }
  global.pause = !global.pause;
}

/*
Flag it as visible.  This is done in the step event instead of the
room start event, because we don't want the HUD being drawn on the
surface of the next room.
*/
visible = true;

/*********************************************************************
-HUD Control Section-

This section is control elements of the HUD, like for example, the
anchor position and rupee counter addition/subtraction.
*********************************************************************/

//If Link is on the top third of the screen or a sideview area...
if (
  objPlayer.y + 16 <=
    (camera_get_view_y(view_camera[0]) +
      camera_get_view_width(view_camera[0])) %
      2 ||
  global.sideview
) {
  /*
    Otherwise, the HUD should be anchored at the top. -4 should be
    the min, since each value of 1 represents 4 pixels.  However, this
    is setup so that negative values will have the hud draw from the
    bottom of the screen, zero will be nowhere (not drawn), and
    positive from the top of the screen.
    */
  if (global.hudanchor > -4) {
    global.hudanchor -= 1;
  }
} else {
  /*
    Then the HUD should be anchored at the bottom.  4 should be the
    max, since each value of 1 represents 4 pixels.  However, this is
    setup so that negative values will have the hud draw from the
    bottom of the screen, zero will be nowhere (not drawn), and
    positive from the top of the screen.
    */
  if (global.hudanchor < 4) {
    global.hudanchor += 1;
  }
}

/*
If Link has less than or equal to 1/4 of his max health, start
playing the danger sound.
*/
if (global.hearts <= floor(global.heartmax / 4)) {
  //If there is a delay on the sound, subtract one of the frames.
  if (dangersnddly) {
    dangersnddly -= 1;
  } else {
    /*
        Otherwise, play the danger sound, and set the length of
        time, in frames, to wait before playing it again.
        */
    audio_play_sound(sndDanger, 10, false);
    dangersnddly = global.onesecond / 2;
  }

  //If there's a delay on the heart blending, subtract a frame.
  if (heartblenddly) {
    heartblenddly -= 1;
  } else {
    //If the blending isn't reversed, do what's in here.
    if (!heartblendreverse) {
      heartblendamt += 1;
      //Add one to the blending amount.
      /*
            If the blending amount is at 4, reverse should be
            activated, and the blending delay should be set.
            */
      if (heartblendamt >= 16) {
        heartblendreverse = true;
        heartblenddly = 1;
      }
    } else {
      heartblendamt -= 1;
      //Take one from the blending amount.
      /*
            If the blending amount is at 0, reverse should be
            de-activated, and the blending delay should be set.
            */
      if (heartblendamt <= 0) {
        heartblendreverse = false;
        heartblenddly = 1;
      }
    }

    /*
        Now set the blending color.
        */
    global.heartblend = make_color_rgb(
      255 - 255 * (heartblendamt / 16),
      255 - 255 * (heartblendamt / 16),
      255 - 255 * (heartblendamt / 16)
    );
  }
} else {
  dangersnddly = 0;
  //Otherwise, reset the sound delay.
  heartblendamt = 0;
  //Reset how much blending is done on the hearts.
  heartblendreverse = false;
  //The blending is no longer reversed.
  heartblenddly = 0;
  //And the blending delay is removed.
  global.heartblend = Color.WHITE;
}

/*
If Link is undergoing healing (or damaging), modify his HP.  Otherwise
reset the stored value of his initial HP before healing to -1.
*/
if (global.heal != 0) {
  /*
    Store the initial value of Link's hearts before the healing
    starts.
    */
  if (oldhearts == -1) {
    oldhearts = global.hearts;
  }

  //Temporary variable for how much to add (or take away).
  var amt = 4;

  //Take care of any overflow.
  if (amt > abs(global.heal)) {
    amt = abs(global.heal);
  }

  /*
    If it's less than 0, than subtract HP.  Otherwise, add it.  Takes
    care of any overflow.
    */
  if (global.heal > 0) {
    global.hearts += amt;
    global.heal -= amt;

    /*
        If the hearts have made it to a full heart from the
        healing, then the heal sound should play.
        */
    if ((global.hearts - oldhearts) % 16 == 0) {
      audio_play_sound(sndHeal, 10, false);
    }
  } else {
    global.hearts -= amt;
    global.heal += amt;
  }
} else {
  oldhearts = -1;
}

/*
If Link's wallet is being added to (or taken from), start changing
the values.
*/
if (global.rupoff != 0) {
  //Temporary variable for how much to affect the rupee counter.
  var amt = max(floor(abs(global.rupoff) / 20), 1);

  /*
    If the value is positive, add rupees, otherwise, take them away.
    */
  if (global.rupoff > 0) {
    global.rupees += amt;
    global.rupoff -= amt;
  } else {
    global.rupees -= amt;
    global.rupoff += amt;
  }

  //Play the sound effect for when the rupee counter is changing.
  audio_play_sound(sndRupeeCounter, 10, false);
}

//If there are frames left for showing the area name, subtract 1.
if (global.showarea > 0) {
  global.showarea -= 1;
}

/* */
/*  */
