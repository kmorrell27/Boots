event_inherited(); //Call the parent script.

/*
If the game is paused, leave this script.
*/
if (scr_pause_check()) {
  exit;
}

/*
Temporary variables for what values the object needs to achieve
on the vertical and horizontal plane.  If the respective speeds
have been reached, the values are 0.  Otherwise, the values are
the needed speeds.
*/
var horgetspd = horspd * !horachieved;
var vergetspd = verspd * !verachieved;

/*
Make the object approach its needed horizontal speed value, faster
if it's further, slower if it's closer.
*/
hspeed += (horgetspd - hspeed) / 4;

/*
If the horizontal speed is relatively close to what it needs
to be, set the speed to 0, and flip the flag of achieving or
unachieving the needed speed.
*/
if (hspeed >= horgetspd - 0.05 && hspeed <= horgetspd + 0.05) {
  hspeed = 0;
  horachieved = !horachieved;
}

/*
Make the object approach its needed vertical speed value, faster
if it's further, slower if it's closer.
*/
vspeed += (vergetspd - vspeed) / 4;

/*
If the horizontal speed is relatively close to what it needs
to be, set the speed to 0, and flip the flag of achieving or
unachieving the needed speed.
*/
if (vspeed >= vergetspd - 0.05 && vspeed <= vergetspd + 0.05) {
  vspeed = 0;
  verachieved = !verachieved;
}

/*
If the object still has some frames left in it's life counter take
one away.  Otherwise, fade out, and if it's no longer visible, delete
it.
*/
if (lifetmr) {
  lifetmr -= 1;
} else {
  image_alpha -= 0.05;
  if (image_alpha <= 0) {
    instance_destroy();
  }
}
