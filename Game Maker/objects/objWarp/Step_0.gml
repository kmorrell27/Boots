/*
Warping can only happen when the player STANDS on a warp object.  Once  do
let's do stuff.*/

if (instance_number(objPlayer) > 1) {
  return;
}

if (place_meeting(x, y, objPlayer) && !global.playerid.jumping) {
  global.lastplayerx =
    global.playerid.x *
    (display_get_gui_width() / camera_get_view_width(view_camera[0]));
  //Store the player's X coordinate.
  global.lastplayery =
    global.playerid.y *
    (display_get_gui_height() / camera_get_view_height(view_camera[0]));
  //Store the player's Y coordinate.
  global.lastviewx = camera_get_view_x(view_camera[0]);
  //Store the view's X coordinate.
  global.lastviewy = camera_get_view_y(view_camera[0]);
  //Store the view's Y coordinate.
  global.playerid.visible = false;
  //Unflag the player as visible.
  objControl.visible = false;
  //Unflag the Control as visible.
  global.playerid.hspeed = 0;
  //Reset the player's horizontal speed.
  global.playerid.vspeed = 0;
  //Reset the player's vertical speed.
  global.playerid.hvel = 0;
  //Reset the player's conserved horizontal velocity.
  global.playerid.vvel = 0;
  //Reset the player's conserved vertical velocity.
  global.playerid.rolling = false;
  //Unflag the player as rolling.
  global.playerid.slashing = false;
  //Unflag the player as slashing.
  //Update the player's sprite.
  with (objPlayer) {
    scr_player_sprite_change();
  }
  //Adjust whether or not the player is considered on the overworld.
  global.inside = inside;
  scr_reset_weather();
  //Reset the weather.
  global.playerid.x = sendx;
  //Place the player on the needed X coordinate.
  global.playerid.y = sendy;
  //Place the player on the needed Y coordinate.
  scr_room_transition(sendr, transition, 60);
  //If this has a sound effect to play, then play it.
  if (entersnd != -1) {
    audio_play_sound(entersnd, 10, false);
  }
}
