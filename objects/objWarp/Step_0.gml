/*
Warping can only happen when Link STANDS on a warp object.  Once he does
let's do stuff.*/

if (place_meeting(x, y, objLink) && !objLink.jumping) {
  //Set the transition type to the one this object needs.
  //Set the number of transition frames to what this object needs.
  global.lastlinkx = objLink.x; //Store Link's X coordinate.
  global.lastlinky = objLink.y; //Store Link's Y coordinate.
  global.lastviewx = camera_get_view_x(view_camera[0]); //Store the views X coordinate.
  global.lastviewy = camera_get_view_y(view_camera[0]); //Store the views Y coordinate.
  objLink.visible = false; //Unflag link as visible.
  objControl.visible = false; //Unflag the Control as visible.
  objWeather.visible = false; //Unflag the Weather as visible.
  objLink.hspeed = 0; //Reset Link's horizontal speed.
  objLink.vspeed = 0; //Reset Link's vertical speed.
  objLink.hvel = 0; //Reset Link's conserved horizontal velocity.
  objLink.vvel = 0; //Reset Link's conserved vertical velocity.
  objLink.rolling = false; //Unflag Link as rolling.
  objLink.defend = false; //Unflag Link as defending.
  objLink.slashing = false; //Unflag Link as slashing.
  objLink.digging = false; //Unflag Link as digging.
  //Update Link's sprite.
  with (objLink) {
    scr_link_sprite_change();
  }
  //Adjust whether or not Link is considered on the overworld.
  global.inside = inside;
  scr_reset_weather(); //Reset the weather.
  scr_room_transition(sendr, transition, 60);
  objLink.x = sendx; //Place Link on the needed X coordinate.
  objLink.y = sendy; //Place Link on the needed Y coordinate.
  //If this has a sound effect to play, then play it.
  if (entersnd != -1) {
    audio_play_sound(entersnd, 10, false);
  }
}