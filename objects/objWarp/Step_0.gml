/*
Warping can only happen when Link STANDS on a warp object.  Once he does
let's do stuff.*/

if (place_meeting(x, y, objPlayer) && !objPlayer.jumping) {
  global.lastlinkx = objPlayer.x *
  (display_get_gui_width() / camera_get_view_width(view_camera[0]));
  //Store Link's X coordinate.
  global.lastlinky = objPlayer.y *
  (display_get_gui_height() / camera_get_view_height(view_camera[0]));
  //Store Link's Y coordinate.
  global.lastviewx = camera_get_view_x(view_camera[0]);
  //Store the view's X coordinate.
  global.lastviewy = camera_get_view_y(view_camera[0]);
  //Store the view's Y coordinate.
  objPlayer.visible = false;
  //Unflag link as visible.
  objControl.visible = false;
  //Unflag the Control as visible.
  objPlayer.hspeed = 0;
  //Reset Link's horizontal speed.
  objPlayer.vspeed = 0;
  //Reset Link's vertical speed.
  objPlayer.hvel = 0;
  //Reset Link's conserved horizontal velocity.
  objPlayer.vvel = 0;
  //Reset Link's conserved vertical velocity.
  objPlayer.rolling = false;
  //Unflag Link as rolling.
  objPlayer.slashing = false;
  //Unflag Link as slashing.
  //Update Link's sprite.
  with (objPlayer) {
    scr_player_sprite_change();
  }
  //Adjust whether or not Link is considered on the overworld.
  global.inside = inside;
  scr_reset_weather();
  //Reset the weather.
  objPlayer.x = sendx;
  //Place Link on the needed X coordinate.
  objPlayer.y = sendy;
  //Place Link on the needed Y coordinate.
  scr_room_transition(sendr, transition, 60);
  //If this has a sound effect to play, then play it.
  if (entersnd != -1) {
    audio_play_sound(entersnd, 10, false);
  }
}
